namespace :logs do
  desc 'Track logs of a chain, network name is from config/pug.yml'
  task :track, %i[network_name] => :environment do |_t, args|
    $stdout.sync = true

    network = Network.find(args[:network_name])
    raise "Network with network_name #{args[:network_name]} not found" if network.nil?

    start_block = network.start_block
    loop do
      ActiveRecord::Base.transaction do
        start_block = scan_logs_of_network(network, start_block) do |logs|
          p logs
          # logs.each do |log|
          #   Pug::EvmLog.create_from(network, log)
          # end
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

# returns next start block
def scan_logs_of_network(network, start_block, &block)
  client = JsonRpcClient.new(network.rpc)

  puts "== Scan `#{network.name}` from #{start_block} {{\n"
  logs, last_scanned_block = client.get_logs(
    network.contracts.map(&:address),
    nil,
    start_block,
    network.max_scan_range
  )

  if last_scanned_block <= start_block
    puts "== }} Done, scanned [#{start_block}, #{last_scanned_block}]\n"
    start_block
  else
    # process logs
    block.call logs, last_scanned_block
    puts "== }} Done, scanned [#{start_block}, #{last_scanned_block}]\n"
    last_scanned_block + 1
  end
end
