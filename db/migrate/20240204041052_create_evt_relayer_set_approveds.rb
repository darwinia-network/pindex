class CreateEvtRelayerSetApproveds < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_relayer_set_approveds do |t|
      t.string :f_operator
      t.boolean :f_approve
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address

      t.timestamps
    end
    add_index :evt_relayer_set_approveds, :f_operator
    add_index :evt_relayer_set_approveds, :f_approve
  end
end
