class CreateEventOracleV2Assigneds < ActiveRecord::Migration[7.1]
  def change
    create_table :event_oracle_v2_assigneds do |t|
      t.string :f_msg_hash
      t.decimal :f_fee, precision: 78, scale: 0
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address
    end
    add_index :event_oracle_v2_assigneds, :f_msg_hash
    add_index :event_oracle_v2_assigneds, :f_fee
  end
end
