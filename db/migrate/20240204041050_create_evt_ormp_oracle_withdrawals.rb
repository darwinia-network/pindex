class CreateEvtOrmpOracleWithdrawals < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_ormp_oracle_withdrawals do |t|
      t.string :f_to
      t.decimal :f_amt, precision: 78, scale: 0
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address

      t.timestamps
    end
    add_index :evt_ormp_oracle_withdrawals, :f_to
    add_index :evt_ormp_oracle_withdrawals, :f_amt
  end
end
