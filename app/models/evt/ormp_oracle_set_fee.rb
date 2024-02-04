# == Schema Information
#
# Table name: evt_ormp_oracle_set_fees
#
#  id                :bigint           not null, primary key
#  f_chain_id        :decimal(78, )
#  f_fee             :decimal(78, )
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Evt::OrmpOracleSetFee < ApplicationRecord
end
