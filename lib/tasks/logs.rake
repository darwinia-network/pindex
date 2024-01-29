namespace :logs do
  desc 'Track logs of a chain, network name is from config/pug.yml'
  task :track, %i[network_name] => :environment do |_t, args|
    $stdout.sync = true

    network = Network.find(args[:network_name])
    raise "Network with network_name #{args[:network_name]} not found" if network.nil?

    loop do
      ActiveRecord::Base.transaction do
        start_block = get_start_block(network)
        scan_logs_of_network(network, start_block) do |logs, next_start_block|
          puts "   #{logs.size} logs found"
          logs.each do |log|
            create_transaction(network, log)
            # Log.create_from(network, log)
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

# create Transaction of this log if not existed
def create_transaction(network, log)
  transaction = Transaction.find_by(chain_id: network.chain_id, transaction_hash: log['transaction_hash'])
  return if transaction

  client = JsonRpcClient.new(network.rpc)
  tx = client.eth_get_transaction_by_hash(log['transaction_hash'])
  Transaction.create!(
    block_hash: tx['blockHash'],
    block_number: tx['blockNumber'].to_i(16),
    chain_id: tx['chainId'].to_i(16),
    from: tx['from'],
    to: tx['to'],
    value: tx['value'].to_i(16),
    gas: tx['gas'].to_i(16),
    gas_price: tx['gasPrice'].to_i(16),
    transaction_hash: tx['hash'],
    input: tx['input'],
    max_priority_fee_per_gas: tx['maxPriorityFeePerGas'].to_i(16),
    max_fee_per_gas: tx['maxFeePerGas'].to_i(16),
    nonce: tx['nonce'].to_i(16),
    r: tx['r'],
    s: tx['s'],
    v: tx['v'].to_i(16),
    transaction_index: tx['transactionIndex'].to_i(16),
    transaction_type: tx['type'].to_i(16)
  )
end

# returns next start block
def scan_logs_of_network(network, start_block)
  client = JsonRpcClient.new(network.rpc)

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
