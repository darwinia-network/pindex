# frozen_string_literal: true

module Types
  class Pug::OrmpMessageAcceptedType < Types::BaseObject
    field :id, ID, null: false
    field :pug_evm_log_id, Integer, null: false
    field :pug_evm_contract_id, Integer, null: false
    field :pug_network_id, Integer, null: false
    field :f_msg_hash, String
    field :f_root, String
    field :f_message_channel, String
    field :f_message_index, Float
    field :f_message_from_chain_id, Float
    field :f_message_from, String
    field :f_message_to_chain_id, Float
    field :f_message_to, String
    field :f_message_gas_limit, Float
    field :f_message_encoded, String
    field :timestamp, GraphQL::Types::ISO8601DateTime
    field :block_number, Integer
    field :transaction_index, Integer
    field :log_index, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
