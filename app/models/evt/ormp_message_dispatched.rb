# == Schema Information
#
# Table name: evt_ormp_message_dispatcheds
#
#  id                :bigint           not null, primary key
#  f_msg_hash        :string
#  f_dispatch_result :boolean
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#
class Evt::OrmpMessageDispatched < ApplicationRecord
end
