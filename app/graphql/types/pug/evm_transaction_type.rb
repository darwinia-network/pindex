# frozen_string_literal: true

module Types
  class Pug::EvmTransactionType < Types::BaseObject
    field :id, ID, null: false
    field :evm_contract_id, Integer
    field :network_id, Integer
    field :block_hash, String
    field :block_number, String
    field :chain_id, String
    field :from, String
    field :to, String
    field :value, String
    field :gas, String
    field :gas_price, String
    field :transaction_hash, String
    field :input, String
    field :max_priority_fee_per_gas, String
    field :max_fee_per_gas, String
    field :nonce, String
    field :r, String
    field :s, String
    field :v, String
    field :transaction_index, String
    field :transaction_type, String
  end
end
