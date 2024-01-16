# == Schema Information
#
# Table name: pug_relayer_set_dst_configs
#
#  id                  :bigint           not null, primary key
#  pug_evm_log_id      :bigint           not null
#  pug_evm_contract_id :bigint           not null
#  pug_network_id      :bigint           not null
#  f_chain_id          :decimal(78, )
#  f_base_gas          :decimal(20, )
#  f_gas_per_byte      :decimal(20, )
#  timestamp           :datetime
#  block_number        :integer
#  transaction_index   :integer
#  log_index           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Pug::RelayerSetDstConfig < ApplicationRecord
  belongs_to :pug_evm_log, class_name: 'Pug::EvmLog'
  alias evm_log pug_evm_log
  belongs_to :pug_evm_contract, class_name: 'Pug::EvmContract'
  alias evm_contract pug_evm_contract
  belongs_to :pug_network, class_name: 'Pug::Network'
  alias network pug_network
end
