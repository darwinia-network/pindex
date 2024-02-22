namespace :signatures do
  desc 'Update signatures of messages'
  task update: :environment do
    $stdout.sync = true

    loop do
      # (root is ready and dispatched) and signatures amount is less than 3
      Message.where(
        'signatures is null OR (jsonb_array_length(signatures) < 5 AND latest_signatures_updated_at > ?)',
        24.hours.ago
      ).each do |message|
        signatures = signatures(message)
        next if signatures.empty?

        message.update(signatures:, latest_signatures_updated_at: Time.current)
        puts "updated signatures of message #{message.msg_hash}"
      end
    rescue StandardError => e
      puts e.message
    ensure
      sleep 2
    end
  end
end

def signatures(message)
  Log.field_eq('chain_id', message.from_chain_id).field_eq('msg_index', message.index).map do |log|
    # Log.field_eq('chain_id', 44).field_eq('msg_index', 1321).map do |log|
    { signer: log.decoded['signer'], signature: log.decoded['signature'] }
  end.uniq
end

# select * from logs where decoded->>'signature' is not null;
# select * from messages where index in (select (decoded->>'msg_index')::INTEGER as msg_index from logs where decoded->>'signature' is not null);
# SELECT "messages".* FROM "messages" WHERE signatures is null or (jsonb_array_length(signatures) = 0);
# update messages set signatures = null;
