class CreateEvtRelayerSetDstConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_relayer_set_dst_configs do |t|
      t.decimal :f_chain_id, precision: 78, scale: 0
      t.decimal :f_base_gas, precision: 20, scale: 0
      t.decimal :f_gas_per_byte, precision: 20, scale: 0
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address

      t.timestamps
    end
    add_index :evt_relayer_set_dst_configs, :f_chain_id
    add_index :evt_relayer_set_dst_configs, :f_base_gas
    add_index :evt_relayer_set_dst_configs, :f_gas_per_byte
  end
end
