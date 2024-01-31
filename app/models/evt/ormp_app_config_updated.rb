# == Schema Information
#
# Table name: evt_ormp_app_config_updateds
#
#  id                :bigint           not null, primary key
#  f_ua              :string
#  f_oracle          :string
#  f_relayer         :string
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#
class Evt::OrmpAppConfigUpdated < ApplicationRecord
end
