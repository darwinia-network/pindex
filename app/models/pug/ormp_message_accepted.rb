# == Schema Information
#
# Table name: pug_ormp_message_accepteds
#
#  id                      :bigint           not null, primary key
#  pug_evm_log_id          :bigint           not null
#  pug_evm_contract_id     :bigint           not null
#  pug_network_id          :bigint           not null
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
#  block_number            :integer
#  transaction_index       :integer
#  log_index               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Pug::OrmpMessageAccepted < ApplicationRecord
  belongs_to :pug_evm_log, class_name: 'Pug::EvmLog'
  alias evm_log pug_evm_log
  belongs_to :pug_evm_contract, class_name: 'Pug::EvmContract'
  alias evm_contract pug_evm_contract
  belongs_to :pug_network, class_name: 'Pug::Network'
  alias network pug_network
end
