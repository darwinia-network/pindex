# == Schema Information
#
# Table name: logs
#
#  id                :bigint           not null, primary key
#  chain_id          :decimal(20, )
#  address           :string
#  data              :text
#  block_hash        :string
#  block_number      :decimal(78, )
#  transaction_hash  :string
#  transaction_index :integer
#  log_index         :integer
#  timestamp         :datetime
#  topic0            :string
#  topic1            :string
#  topic2            :string
#  topic3            :string
#  event_name        :string
#  decoded           :jsonb
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Log < ApplicationRecord
  include AbiCoderRb

  alias_attribute :signature, :topic0

  # scopes for decoded field query
  # https://www.postgresql.org/docs/9.5/functions-json.html
  # https://www.reddit.com/r/rails/comments/10a1fww/jsonb_queries_cheatsheet/
  scope :field_eq, ->(field, value) { where('decoded->>? = ?', field, value) }
  scope :field_gt, ->(field, value) { where('decoded->>? > ?', field, value) }
  scope :field_gte, ->(field, value) { where('decoded->>? >= ?', field, value) }
  scope :field_lt, ->(field, value) { where('decoded->>? < ?', field, value) }
  scope :field_lte, ->(field, value) { where('decoded->>? <= ?', field, value) }

  def topics
    [topic0, topic1, topic2, topic3].compact
  end

  def decode!
    contract = Contract.find_by_address(chain_id, address)

    self.event_name = contract.event_name(topic0)
    p event_name

    event_abi = contract.raw_event_abi(topic0)
    event_decoder = EventDecoder.new(event_abi)

    decoded_topics = event_decoder.decode_topics(topics, with_names: true)
    decoded_data = event_decoder.decode_data(data, with_names: true, flatten: true, sep: '_')

    # save decoded data to decoded field
    #########################################
    self.decoded = decoded_topics.merge(decoded_data)
    save!

    p decoded
    puts ''

    # save decoded data to model
    #########################################
    event_model_name = contract.event_full_name(topic0)
    event_model_class = Event.const_get(event_model_name)

    record = decoded_topics.merge(decoded_data)
    record = record.transform_keys { |key| "f_#{key}" }
    record[:pug_contract] = contract
    record[:pug_evm_log] = self
    record[:pug_network] = network
    record[:block_number] = block_number
    record[:transaction_index] = transaction_index
    record[:log_index] = log_index
    record[:timestamp] = timestamp

    if event_model_class.find_by(
      pug_network: record[:pug_network],
      block_number: record[:block_number],
      transaction_index: record[:transaction_index],
      log_index: record[:log_index]
    ).blank?
      event_model_class.create!(record)
    end
  end
end
