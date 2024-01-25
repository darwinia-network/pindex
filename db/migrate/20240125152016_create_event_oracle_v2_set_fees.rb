class CreateEventOracleV2SetFees < ActiveRecord::Migration[7.1]
  def change
    create_table :event_oracle_v2_set_fees do |t|
      t.decimal :f_chain_id, precision: 78, scale: 0
      t.decimal :f_fee, precision: 78, scale: 0
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address
    end
    add_index :event_oracle_v2_set_fees, :f_chain_id
    add_index :event_oracle_v2_set_fees, :f_fee
  end
end
