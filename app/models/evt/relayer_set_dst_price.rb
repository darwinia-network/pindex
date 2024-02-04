# == Schema Information
#
# Table name: evt_relayer_set_dst_prices
#
#  id                     :bigint           not null, primary key
#  f_chain_id             :decimal(78, )
#  f_dst_price_ratio      :decimal(39, )
#  f_dst_gas_price_in_wei :decimal(39, )
#  timestamp              :datetime
#  block_number           :decimal(78, )
#  transaction_index      :integer
#  log_index              :integer
#  chain_id               :decimal(20, )
#  contract_address       :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Evt::RelayerSetDstPrice < ApplicationRecord
end
