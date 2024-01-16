class CreatePugOrmpMessageAccepteds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_message_accepteds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :f_msg_hash
      t.string :f_root
      t.string :f_message_channel
      t.decimal :f_message_index, precision: 78, scale: 0
      t.decimal :f_message_from_chain_id, precision: 78, scale: 0
      t.string :f_message_from
      t.decimal :f_message_to_chain_id, precision: 78, scale: 0
      t.string :f_message_to
      t.decimal :f_message_gas_limit, precision: 78, scale: 0
      t.string :f_message_encoded
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_msg_hash]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_root]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_message_channel]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_message_index]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_message_from_chain_id]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_message_from]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_message_to_chain_id]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_message_to]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_message_gas_limit]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :f_message_encoded]
    add_index :pug_ormp_message_accepteds, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
