# == Schema Information
#
# Table name: evt_ormp_oracle_ownership_transferreds
#
#  id                :bigint           not null, primary key
#  f_previous_owner  :string
#  f_new_owner       :string
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Evt::OrmpOracleOwnershipTransferred < ApplicationRecord
end
