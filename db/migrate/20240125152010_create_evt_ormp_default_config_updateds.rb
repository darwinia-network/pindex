class CreateEvtOrmpDefaultConfigUpdateds < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_ormp_default_config_updateds do |t|
      t.string :f_oracle
      t.string :f_relayer
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address
    end
    add_index :evt_ormp_default_config_updateds, :f_oracle
    add_index :evt_ormp_default_config_updateds, :f_relayer
  end
end
