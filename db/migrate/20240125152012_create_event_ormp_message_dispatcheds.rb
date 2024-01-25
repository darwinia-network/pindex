class CreateEventOrmpMessageDispatcheds < ActiveRecord::Migration[7.1]
  def change
    create_table :event_ormp_message_dispatcheds do |t|
      t.string :f_msg_hash
      t.boolean :f_dispatch_result
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address
    end
    add_index :event_ormp_message_dispatcheds, :f_msg_hash
    add_index :event_ormp_message_dispatcheds, :f_dispatch_result
  end
end
