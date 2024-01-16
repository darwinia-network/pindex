class CreatePugOracleV2ImporedMessageRoots < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_oracle_v2_impored_message_roots do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :f_chaind_id, precision: 78, scale: 0
      t.decimal :f_block_number, precision: 78, scale: 0
      t.string :f_message_root
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_oracle_v2_impored_message_roots, [:pug_network_id, :f_chaind_id]
    add_index :pug_oracle_v2_impored_message_roots, [:pug_network_id, :f_block_number]
    add_index :pug_oracle_v2_impored_message_roots, [:pug_network_id, :f_message_root]
    add_index :pug_oracle_v2_impored_message_roots, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
