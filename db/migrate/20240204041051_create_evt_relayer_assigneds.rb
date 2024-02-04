class CreateEvtRelayerAssigneds < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_relayer_assigneds do |t|
      t.string :f_msg_hash
      t.decimal :f_fee, precision: 78, scale: 0
      t.string :f_params
      t.string :f_proof
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address

      t.timestamps
    end
    add_index :evt_relayer_assigneds, :f_msg_hash
    add_index :evt_relayer_assigneds, :f_fee
    add_index :evt_relayer_assigneds, :f_params
    add_index :evt_relayer_assigneds, :f_proof
  end
end
