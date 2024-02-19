namespace :messages do
  desc 'Start tracing messages'
  task :trace, %i[network_name] => :environment do |_t, args|
    $stdout.sync = true

    network = Network.find(args[:network_name])
    raise "Network with network_name #{args[:network_name]} not found" if network.nil?

    loop do
      puts '== SYNCRONIZING ==============================='
      puts "sync new accepted messages of #{network.name}"
      sync_accepted_messages(network)

      puts "check accepted messages of #{network.name}"
      check_accepted_messages(network)

      puts "check root ready messages of #{network.name}"
      check_root_ready_messages(network)

      puts "\n"
      sleep 10
    rescue StandardError => e
      puts e
      puts e.backtrace.join("\n")

      sleep 10
    end
  end
end

# root_ready -> dispatch_success/dispatch_failed
def check_root_ready_messages(network)
  messages = Message.where(from_chain_id: network.chain_id)
                    .where(status: %i[accepted root_ready])

  messages.each do |message|
    dispatched_log = Log.where(chain_id: message.to_chain_id)
                        .where(event_name: 'MessageDispatched')
                        .field_eq('msg_hash', message.msg_hash)
                        .first
    next if dispatched_log.nil?

    message.dispatch_transaction_hash = dispatched_log.transaction_hash
    message.dispatch_block_number = dispatched_log.block_number
    message.dispatch_block_timestamp = Time.at(dispatched_log.timestamp)
    message.status = if dispatched_log.decoded['dispatch_result']
                       Message.statuses[:dispatch_success]
                     else
                       Message.statuses[:dispatch_failed]
                     end

    # update proof
    transaction = Transaction.find_by_transaction_hash(dispatched_log.transaction_hash)
    message.proof = transaction.input[(-32 * 64)..].scan(/.{64}/).map { |item| "0x#{item}" }

    message.save!
  end
end

# accepted -> root_ready
def check_accepted_messages(network)
  messages = Message.where(from_chain_id: network.chain_id)
                    .where(status: :accepted)
  messages.each do |message|
    next unless root_prepared?(message)

    message.update(status: :root_ready)
  end
end

def root_prepared?(message)
  # find the latest ImportedMessageRoot log on the target chain
  m_log = Log.where(chain_id: message.to_chain_id)
             .where(event_name: 'ImportedMessageRoot')
             .order(timestamp: :desc).first
  return false if m_log.nil?

  # find the message of the root on the source chain by root
  message_of_root = Message.find_by(
    root: m_log.decoded['message_root']
  )
  return false if message_of_root.nil?

  message.block_number <= message_of_root.block_number
end

def sync_accepted_messages(network)
  latest_message_accepted_logs(network).each do |log|
    next if skip_message?(log, network)

    ActiveRecord::Base.transaction do
      message = Message.create!(
        msg_hash: log.decoded['msg_hash'],
        root: log.decoded['root'],
        channel: log.decoded['message_channel'],
        index: log.decoded['message_index'],
        from_chain_id: log.decoded['message_from_chain_id'],
        from: log.decoded['message_from'],
        to_chain_id: log.decoded['message_to_chain_id'],
        to: log.decoded['message_to'],
        encoded: log.decoded['message_encoded'],
        gas_limit: log.decoded['message_gas_limit'],
        block_number: log.block_number,
        block_timestamp: Time.at(log.timestamp),
        transaction_hash: log.transaction_hash,
        status: :accepted
      )
      raise "Message created failed: #{message.errors.full_messages}" if message.errors.any?
    end
  end
end

def skip_message?(message_accepted_log, network)
  # skip if message already exists
  return true if Message.find_by(from_chain_id: network.chain_id, msg_hash: message_accepted_log.decoded['msg_hash'])

  # 在测试网环境下，crab是测试网链，从crab链发出的，但是目标不是测试网链的消息，不处理
  # 在主网环境下，crab是主网链，从crab链发出的，但是目标不是主网链的消息，不处理
  chains = Network.all.map(&:chain_id).reject { |chain_id| chain_id == 44 }
  right_target_chain = chains.include?(message_accepted_log.decoded['message_to_chain_id'].to_i)
  crab_with_wrong_to_chain = network.chain_id == 44 && !right_target_chain
  return true if crab_with_wrong_to_chain

  false
end

def latest_message_accepted_logs(network)
  last_message_index = Message.where(from_chain_id: network.chain_id).maximum(:index) || -1
  puts "From `#{network.name}`s message index: #{last_message_index + 1}"

  Log.where(chain_id: network.chain_id)
     .where(event_name: 'MessageAccepted')
     .where("(decoded->>'message_index')::int > ?", last_message_index)
end
