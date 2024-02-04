class CreateEvtOrmpOracleImportedMessageRoots < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_ormp_oracle_imported_message_roots do |t|
      t.decimal :f_chain_id, precision: 78, scale: 0
      t.decimal :f_message_index, precision: 78, scale: 0
      t.string :f_message_root
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address

      t.timestamps
    end
    add_index :evt_ormp_oracle_imported_message_roots, :f_chain_id
    add_index :evt_ormp_oracle_imported_message_roots, :f_message_index
    add_index :evt_ormp_oracle_imported_message_roots, :f_message_root
  end
end
