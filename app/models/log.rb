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

  def decode
    puts address.class
    contract = Contract.find_by_address(chain_id, address)

    self.event_name = contract.event_name(topic0)
    p event_name

    event_abi = contract.raw_event_abi(topic0)
    event_decoder = EventDecoder.new(event_abi)

    decoded_topics = event_decoder.decode_topics(topics, with_names: true)
    decoded_data = event_decoder.decode_data(data, with_names: true, flatten: true, sep: '_')

    self.decoded = decoded_topics.merge(decoded_data)

    p decoded
    puts ''
  end

  def create_event_model!
    contract = Contract.find_by_address(chain_id, address)

    event_model_name = event_model_name(contract.name, event_name)
    event_model_class = Object.const_get("Evt::#{event_model_name}")

    return unless event_model_class.present?

    # event fields
    record = decoded
    record = record.transform_keys { |key| "f_#{key}" }
    # add extra fields
    record[:timestamp] = timestamp
    record[:block_number] = block_number
    record[:transaction_index] = transaction_index
    record[:log_index] = log_index
    record[:chain_id] = chain_id
    record[:contract_address] = address

    puts event_model_class
    puts event_model_class.class
    if event_model_class.find_by(
      chain_id: record[:chain_id],
      block_number: record[:block_number],
      transaction_index: record[:transaction_index],
      log_index: record[:log_index]
    ).blank?
      event_model_class.create!(record)
    end
  end

  def event_model_name(contract_name, event_name)
    model_name = "#{contract_name.underscore}_#{event_name.underscore}"
    if model_name.pluralize.length > 63
      model_name = "#{shorten_string(contract_name.underscore)}_#{event_name.underscore}"
    end
    model_name.singularize.camelize
  end
end
