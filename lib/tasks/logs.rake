require 'client_wrapper'

namespace :logs do
  desc 'Trace logs of a chain, network name is from config/pindex.yml'
  task :trace, %i[network_name] => :environment do |_t, args|
    $stdout.sync = true

    network = Network.find(args[:network_name])
    raise "Network with network_name #{args[:network_name]} not found" if network.nil?

    client = ClientWrapper.new(network.rpc)

    loop do
      start_block = get_start_block(network)
      scan_logs_of_network(client, network, start_block) do |logs, next_start_block|
        puts "#{logs.size} logs found"
        logs.each do |log|
          process_log(client, network, log)
        end
        update_start_block(network, next_start_block)
      end
    rescue StandardError => e
      if e.class != RunTooFast
        puts e.message
        puts e.backtrace.join("\n")
      end
      sleep 3 # sleep extra time
    ensure
      sleep network.polling_interval
    end
  end

  desc 'Fetch logs manually'
  task :fetch, %i[network_name start_block interval] => :environment do |_t, args|
    network = Network.find(args[:network_name])
    raise "Network with network_name #{args[:network_name]} not found" if network.nil?

    client = ClientWrapper.new(network.rpc)

    addresses = network.contracts.map(&:address)
    logs, last_scanned_block = client.get_logs(
      addresses,
      nil,
      args[:start_block].to_i,
      args[:interval].to_i
    )

    puts "== scanned logs from #{args[:start_block]} to #{last_scanned_block}"
    logs.each do |log|
      puts '--------------------------------'
      p log
      create_transaction(client, network.chain_id, log['transaction_hash'])
      create_block(client, network.chain_id, log['block_number'])
      m_log = create_log(network.chain_id, log)
      create_event_model(m_log)
    end
  end
end

def process_log(client, network, log)
  ActiveRecord::Base.transaction do
    create_transaction(client, network.chain_id, log['transaction_hash'])
    create_block(client, network.chain_id, log['block_number'])
    m_log = create_log(network.chain_id, log)
    create_event_model(m_log)
  end
rescue StandardError => e
  puts e.message
  puts e.backtrace.join("\n")
  sleep 5
  process_log(client, network, log)
end

def create_log(chain_id, log)
  m_log = Log.find_by(
    chain_id:,
    block_number: log['block_number'],
    transaction_index: log['transaction_index'],
    log_index: log['log_index']
  )
  if m_log
    puts "Log already exist: #{m_log.id}, #{chain_id}, #{m_log.event_name}"
    return m_log
  end

  m_log = Log.new(
    chain_id:,
    address: log['address'].to_s,
    data: log['data'],
    block_number: log['block_number'],
    transaction_hash: log['transaction_hash'],
    transaction_index: log['transaction_index'],
    block_hash: log['block_hash'],
    log_index: log['log_index'],
    timestamp: log['timestamp']
  )
  log['topics'].each_with_index do |topic, index|
    m_log.send("topic#{index}=", topic)
  end

  m_log.save!

  m_log
end

def create_event_model(m_log)
  # lookup event model
  contract = Contract.find_by_address(m_log.chain_id, m_log.address)
  event_model_name = "Evt::#{event_model_name(contract.name, m_log.event_name)}"

  # skip create event model if not event model found
  return unless Object.const_defined?(event_model_name)

  event_model_class = Object.const_get(event_model_name)

  return if event_model_class.find_by(
    chain_id: m_log.chain_id,
    block_number: m_log.block_number,
    transaction_index: m_log.transaction_index,
    log_index: m_log.log_index
  ).present?

  record = m_log.event_model_record
  event_model_class.create!(record)
end

def event_model_name(contract_name, event_name)
  model_name = "#{contract_name.underscore}_#{event_name.underscore}"
  if model_name.pluralize.length > 63
    model_name = "#{shorten_string(contract_name.underscore)}_#{event_name.underscore}"
  end
  model_name.singularize.camelize
end

# create Transaction of this log if not exist
def create_transaction(client, chain_id, transaction_hash)
  transaction = Transaction.find_by(chain_id:, transaction_hash:)
  return if transaction

  tx = client.eth_get_transaction_by_hash(transaction_hash)
  Transaction.create!(
    block_hash: tx['blockHash'],
    block_number: tx['blockNumber'].to_i(16),
    chain_id:,
    from: tx['from'],
    to: tx['to'],
    value: tx['value'].to_i(16),
    gas: tx['gas'].to_i(16),
    gas_price: tx['gasPrice'].to_i(16),
    transaction_hash: tx['hash'],
    input: tx['input'],
    max_priority_fee_per_gas: tx['maxPriorityFeePerGas'].present? ? tx['maxPriorityFeePerGas'].to_i(16) : nil,
    max_fee_per_gas: tx['maxFeePerGas'].present? ? tx['maxFeePerGas'].to_i(16) : nil,
    nonce: tx['nonce'].to_i(16),
    r: tx['r'],
    s: tx['s'],
    v: tx['v'].to_i(16),
    transaction_index: tx['transactionIndex'].to_i(16),
    transaction_type: tx['type'].to_i(16)
  )
end

def create_block(client, chain_id, block_number)
  block = Block.find_by(chain_id:, block_number:)
  return if block

  block = client.eth_get_block_by_number(block_number, true)
  Block.create!(
    chain_id:,
    block_hash: block['hash'],
    block_number: block['number'].to_i(16),
    base_fee_per_gas: block['baseFeePerGas'].to_i(16),
    difficulty: block['difficulty'].to_i(16),
    extra_data: block['extraData'],
    gas_limit: block['gasLimit'].to_i(16),
    gas_used: block['gasUsed'].to_i(16),
    logs_bloom: block['logsBloom'],
    miner: block['miner'],
    mix_hash: block['mixHash'],
    nonce: block['nonce'],
    parent_hash: block['parentHash'],
    receipts_root: block['receiptsRoot'],
    sha3_uncles: block['sha3Uncles'],
    size: block['size'].to_i(16),
    state_root: block['stateRoot'],
    timestamp: block['timestamp'].to_i(16),
    total_difficulty: block['totalDifficulty'].to_i(16),
    transactions_root: block['transactionsRoot']
  )
end

# returns next start block
def scan_logs_of_network(client, network, start_block)
  logs, last_scanned_block = client.get_logs(
    network.contracts.map(&:address),
    nil,
    start_block,
    network.max_scan_range
  )

  puts "== scan logs of `#{network.name}` in [#{start_block} .. #{last_scanned_block}]"
  # process logs
  yield logs, last_scanned_block + 1
end

def get_start_block(network)
  # get start block from file
  File.open("#{Rails.root}/.pindex/#{network.name}_start_block", 'r').read.strip.to_i
rescue Errno::ENOENT
  network.start_block
end

def update_start_block(network, next_start_block)
  # update start block to file
  File.open("#{Rails.root}/.pindex/#{network.name}_start_block", 'w') do |f|
    f.write(next_start_block)
  end
end
