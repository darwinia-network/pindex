class CreatePugOracleV2SetFees < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_oracle_v2_set_fees do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :f_chain_id, precision: 78, scale: 0
      t.decimal :f_fee, precision: 78, scale: 0
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_oracle_v2_set_fees, [:pug_network_id, :f_chain_id]
    add_index :pug_oracle_v2_set_fees, [:pug_network_id, :f_fee]
    add_index :pug_oracle_v2_set_fees, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
