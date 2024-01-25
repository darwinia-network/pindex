# frozen_string_literal: true

module Types
  class Pug::EvmContractType < Types::BaseObject
    field :id, ID, null: false
    field :network_id, Integer
    field :address, String
    field :name, String
    field :abi_file, String
    field :creator, String
    field :creation_block, Integer
    field :creation_tx_hash, String
    field :creation_timestamp, GraphQL::Types::ISO8601DateTime
    field :last_scanned_block, Integer
    field :tron_address, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
