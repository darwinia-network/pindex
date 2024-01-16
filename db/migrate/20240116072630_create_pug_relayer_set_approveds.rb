class CreatePugRelayerSetApproveds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_relayer_set_approveds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :f_operator
      t.boolean :f_approve
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_relayer_set_approveds, [:pug_network_id, :f_operator]
    add_index :pug_relayer_set_approveds, [:pug_network_id, :f_approve]
    add_index :pug_relayer_set_approveds, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
