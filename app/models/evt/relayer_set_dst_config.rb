# == Schema Information
#
# Table name: evt_relayer_set_dst_configs
#
#  id                :bigint           not null, primary key
#  f_chain_id        :decimal(78, )
#  f_base_gas        :decimal(20, )
#  f_gas_per_byte    :decimal(20, )
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Evt::RelayerSetDstConfig < ApplicationRecord
end
