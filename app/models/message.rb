# == Schema Information
#
# Table name: messages
#
#  id                           :bigint           not null, primary key
#  index                        :integer
#  msg_hash                     :string
#  root                         :string
#  channel                      :string
#  from_chain_id                :decimal(20, )
#  from                         :string
#  to_chain_id                  :decimal(20, )
#  to                           :string
#  block_number                 :bigint
#  block_timestamp              :datetime
#  transaction_hash             :string
#  status                       :integer
#  encoded                      :text
#  dispatch_transaction_hash    :string
#  dispatch_block_number        :bigint
#  dispatch_block_timestamp     :datetime
#  proof                        :jsonb
#  gas_limit                    :decimal(78, )
#  msgport_payload              :text
#  msgport_from                 :string
#  msgport_to                   :string
#  signatures                   :jsonb
#  latest_signatures_updated_at :datetime
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
class Message < ApplicationRecord
  # dispatch will have 2 status: dispatched and success, dispatched but failed
  enum status: { accepted: 0, root_ready: 1, dispatch_success: 2, dispatch_failed: 3, cleared: 4 }

  def status_label
    if status == 'accepted'
      'Accepted'
    elsif status == 'root_ready'
      'Root Ready'
    elsif status == 'dispatch_success'
      'Success'
    elsif status == 'dispatch_failed'
      'Failed'
    elsif status == 'cleared'
      'Cleared'
    else
      'Unknown'
    end
  end

  def from_network
    Network.find(from_chain_id)
  end

  def to_network
    Network.find(to_chain_id)
  end

  after_create_commit :extract_msgport_payload

  # https://sepolia.arbiscan.io/tx/0xb1bd91053e0cfb86121ad7d04a1ed93c841d9eaa877ee6ca6bb1280ccc47ce46
  #
  # https://github.com/darwinia-network/darwinia-msgport/blob/6f751cf02f2ea0fbb2de401cd3cf07cca68e1b49/src/lines/ORMPLine.sol#L64
  # recv(address,address,bytes)
  # 0x394d1bca
  #   0000000000000000000000009f33a4809aa708d7a399fedba514e0a0d15efa85 <- `source EA` address
  #   000000000000000000000000422df988fda9c7bac5750ee9ea6a46d7a024e99e <- `target EA` address
  #   0000000000000000000000000000000000000000000000000000000000000060
  #   0000000000000000000000000000000000000000000000000000000000000064
  #   d8e6817200000000000000000000000000000000000000000000000000000000 <- the message sent to `target EA`
  #   0000002000000000000000000000000000000000000000000000000000000000
  #   0000000212340000000000000000000000000000000000000000000000000000
  #   0000000000000000000000000000000000000000000000000000000000000000
  #   0e3bede4f813af49d539dba8bf19f49386acd6670a5ffea93814d7a5ce5291c2
  #   000000000000000000000000000000000000000000000000000000000000002c
  #   001ddfd752a071964fe15c2386ec1811963d00c2
  def extract_msgport_payload
    # extract msgport payload if it is a msgport message
    return unless encoded.start_with?('0x394d1bca')

    self.msgport_from = '0x' + encoded[34..73]
    self.msgport_to = '0x' + encoded[98..137]
    self.msgport_payload = '0x' + encoded[266..]
    save!
  end

  def identifier
    "#{Network.find(from_chain_id).name}_#{Network.find(to_chain_id).name}_#{index}"
  end

  def direction
    "#{Network.find(from_chain_id).name}->#{Network.find(to_chain_id).name}"
  end

  # after_commit :broadcast_message

  def broadcast_message
    if updated_at.to_s == created_at.to_s
      broadcast_prepend_to(
        'messages',
        target: 'messages',
        partial: 'messages/message',
        locals: { message: self }
      )
      broadcast_replace_to(
        'messages_count',
        target: 'messages_count',
        partial: 'messages/messages_count',
        locals: { messages_count: Message.count }
      )
    else
      broadcast_replace_to(
        'messages',
        target: "message_#{identifier}",
        partial: 'messages/message',
        locals: { message: self }
      )
      broadcast_replace_to(
        'message',
        target: "message_#{identifier}",
        partial: 'messages/show_message',
        locals: { message: self }
      )
    end
  end
end
