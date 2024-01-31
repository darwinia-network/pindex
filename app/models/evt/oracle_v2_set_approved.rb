# == Schema Information
#
# Table name: evt_oracle_v2_set_approveds
#
#  id                :bigint           not null, primary key
#  f_operator        :string
#  f_approve         :boolean
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#
class Evt::OracleV2SetApproved < ApplicationRecord
end
