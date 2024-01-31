# == Schema Information
#
# Table name: evt_ormp_message_accepteds
#
#  id                      :bigint           not null, primary key
#  f_msg_hash              :string
#  f_root                  :string
#  f_message_channel       :string
#  f_message_index         :decimal(78, )
#  f_message_from_chain_id :decimal(78, )
#  f_message_from          :string
#  f_message_to_chain_id   :decimal(78, )
#  f_message_to            :string
#  f_message_gas_limit     :decimal(78, )
#  f_message_encoded       :string
#  timestamp               :datetime
#  block_number            :decimal(78, )
#  transaction_index       :integer
#  log_index               :integer
#  chain_id                :decimal(20, )
#  contract_address        :string
#
class Evt::OrmpMessageAccepted < ApplicationRecord
end
