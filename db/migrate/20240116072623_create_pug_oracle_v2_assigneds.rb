class CreatePugOracleV2Assigneds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_oracle_v2_assigneds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :f_msg_hash
      t.decimal :f_fee, precision: 78, scale: 0
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_oracle_v2_assigneds, [:pug_network_id, :f_msg_hash]
    add_index :pug_oracle_v2_assigneds, [:pug_network_id, :f_fee]
    add_index :pug_oracle_v2_assigneds, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
