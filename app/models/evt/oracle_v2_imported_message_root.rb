# == Schema Information
#
# Table name: evt_oracle_v2_imported_message_roots
#
#  id                :bigint           not null, primary key
#  f_chain_id        :decimal(78, )
#  f_block_height    :decimal(78, )
#  f_message_root    :string
#  timestamp         :datetime
#  block_number      :decimal(78, )
#  transaction_index :integer
#  log_index         :integer
#  chain_id          :decimal(20, )
#  contract_address  :string
#
class Evt::OracleV2ImportedMessageRoot < ApplicationRecord
end
