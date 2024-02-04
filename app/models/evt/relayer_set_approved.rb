# == Schema Information
#
# Table name: evt_relayer_set_approveds
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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Evt::RelayerSetApproved < ApplicationRecord
end
