namespace :logs do
  desc 'Track logs of a chain, network name is from config/pug.yml'
  task :track, %i[network_name] => :environment do |_t, args|
    $stdout.sync = true

    network = Network.find(args[:network_name])
    raise "Network with network_name #{args[:network_name]} not found" if network.nil?

    client = JsonRpcClient.new(network.rpc)

    loop do
      ActiveRecord::Base.transaction do
        start_block = get_start_block(network)
        scan_logs_of_network(client, network, start_block) do |logs, next_start_block|
          puts "   #{logs.size} logs found"
          logs.each do |log|
            create_log_if_not_existed(network.chain_id, log)
            create_transaction_if_not_existed(client, network.chain_id, log['transaction_hash'])
            create_block_if_not_existed(client, network.chain_id, log['block_number'])
          end

          update_start_block(network, next_start_block)
        end
      end
    rescue StandardError => e
      puts e.message
      puts e.backtrace.join("\n")
    ensure
      sleep 5
    end
  end
end

def create_log_if_not_existed(chain_id, log)
  evm_log = Log.find_by(
    chain_id:,
    block_number: log['block_number'],
    transaction_index: log['transaction_index'],
    log_index: log['log_index']
  )
  return if evm_log

  evm_log = Log.new(
    chain_id:,
    address: log['address'],
    data: log['data'],
    block_number: log['block_number'],
    transaction_hash: log['transaction_hash'],
    transaction_index: log['transaction_index'],
    block_hash: log['block_hash'],
    log_index: log['log_index'],
    timestamp: Time.at(log['timestamp'])
  )
  log['topics'].each_with_index do |topic, index|
    evm_log.send("topic#{index}=", topic)
  end

  evm_log.save!
end

# create Transaction of this log if not existed
def create_transaction_if_not_existed(client, chain_id, transaction_hash)
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

def create_block_if_not_existed(client, chain_id, block_number)
  block = Block.find_by(chain_id:, block_number:)
  return if block

  block = client.eth_get_block_by_number(block_number, true)
  p block
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
  puts "== scan logs of `#{network.name}` from #{start_block}"
  logs, last_scanned_block = client.get_logs(
    network.contracts.map(&:address),
    nil,
    start_block,
    network.max_scan_range
  )

  if last_scanned_block <= start_block
    yield logs, start_block
  else
    # process logs
    yield logs, last_scanned_block + 1
  end
end

def get_start_block(network)
  # get start block from file
  File.open("#{Rails.root}/.pug/#{network.name}_start_block", 'r').read.strip.to_i
rescue Errno::ENOENT
  network.start_block
end

def update_start_block(network, next_start_block)
  # update start block to file
  File.open("#{Rails.root}/.pug/#{network.name}_start_block", 'w') do |f|
    f.write(next_start_block)
  end
end
