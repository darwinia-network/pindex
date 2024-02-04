class CreateEvtOrmpOracleOwnershipTransferreds < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_ormp_oracle_ownership_transferreds do |t|
      t.string :f_previous_owner
      t.string :f_new_owner
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address

      t.timestamps
    end
    add_index :evt_ormp_oracle_ownership_transferreds, :f_previous_owner
    add_index :evt_ormp_oracle_ownership_transferreds, :f_new_owner
  end
end
