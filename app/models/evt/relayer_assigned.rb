# == Schema Information
#
# Table name: evt_relayer_assigneds
#
#  id                :bigint           not null, primary key
#  f_msg_hash        :string
#  f_fee             :decimal(78, )
#  f_params          :string
#  f_proof           :string
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Evt::RelayerAssigned < ApplicationRecord
end
