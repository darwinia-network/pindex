# == Schema Information
#
# Table name: blocks
#
#  id                :bigint           not null, primary key
#  chain_id          :decimal(20, )
#  block_hash        :string
#  block_number      :bigint
#  base_fee_per_gas  :decimal(78, )
#  difficulty        :decimal(78, )
#  extra_data        :text
#  gas_limit         :decimal(78, )
#  gas_used          :decimal(78, )
#  logs_bloom        :string
#  miner             :string
#  mix_hash          :string
#  nonce             :string
#  parent_hash       :string
#  receipts_root     :string
#  sha3_uncles       :string
#  size              :decimal(78, )
#  state_root        :string
#  timestamp         :integer
#  total_difficulty  :decimal(78, )
#  transactions_root :string
#
class Block < ApplicationRecord
end
