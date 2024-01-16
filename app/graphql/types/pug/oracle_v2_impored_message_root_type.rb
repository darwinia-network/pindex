# frozen_string_literal: true

module Types
  class Pug::OracleV2ImporedMessageRootType < Types::BaseObject
    field :id, ID, null: false
    field :pug_evm_log_id, Integer, null: false
    field :pug_evm_contract_id, Integer, null: false
    field :pug_network_id, Integer, null: false
    field :f_chaind_id, Float
    field :f_block_number, Float
    field :f_message_root, String
    field :timestamp, GraphQL::Types::ISO8601DateTime
    field :block_number, Integer
    field :transaction_index, Integer
    field :log_index, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
