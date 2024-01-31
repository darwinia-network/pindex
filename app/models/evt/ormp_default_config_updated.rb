# == Schema Information
#
# Table name: evt_ormp_default_config_updateds
#
#  id                :bigint           not null, primary key
#  f_oracle          :string
#  f_relayer         :string
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#
class Evt::OrmpDefaultConfigUpdated < ApplicationRecord
  # self.table_name = 'event_ormp_app_config_updateds'
end
