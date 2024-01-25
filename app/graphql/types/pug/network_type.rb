# frozen_string_literal: true

module Types
  class Pug::NetworkType < Types::BaseObject
    field :id, ID, null: false
    field :chain_id, Integer
    field :name, String
    field :display_name, String
    field :rpc, String
    field :explorer, String
    field :scan_span, Integer
    field :last_scanned_block, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
