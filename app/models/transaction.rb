# == Schema Information
#
# Table name: transactions
#
#  id                       :bigint           not null, primary key
#  chain_id                 :decimal(20, )
#  transaction_hash         :string
#  block_hash               :string
#  block_number             :bigint
#  from                     :string
#  to                       :string
#  value                    :decimal(78, )
#  gas                      :decimal(78, )
#  gas_price                :decimal(78, )
#  input                    :text
#  max_priority_fee_per_gas :decimal(78, )
#  max_fee_per_gas          :decimal(78, )
#  nonce                    :integer
#  r                        :string
#  s                        :string
#  v                        :decimal(78, )
#  transaction_index        :integer
#  transaction_type         :string
#
class Transaction < ApplicationRecord
  # belongs_to :network
  # belongs_to :evm_contract
end
