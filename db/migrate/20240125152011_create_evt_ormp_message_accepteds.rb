class CreateEvtOrmpMessageAccepteds < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_ormp_message_accepteds do |t|
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
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address
    end
    add_index :evt_ormp_message_accepteds, :f_msg_hash
    add_index :evt_ormp_message_accepteds, :f_root
    add_index :evt_ormp_message_accepteds, :f_message_channel
    add_index :evt_ormp_message_accepteds, :f_message_index
    add_index :evt_ormp_message_accepteds, :f_message_from_chain_id
    add_index :evt_ormp_message_accepteds, :f_message_from
    add_index :evt_ormp_message_accepteds, :f_message_to_chain_id
    add_index :evt_ormp_message_accepteds, :f_message_to
    add_index :evt_ormp_message_accepteds, :f_message_gas_limit
    add_index :evt_ormp_message_accepteds, :f_message_encoded
  end
end
