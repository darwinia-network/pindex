class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :index
      t.string :msg_hash
      t.string :root
      t.string :channel
      t.decimal :from_chain_id, precision: 20, scale: 0
      t.string :from
      t.decimal :to_chain_id, precision: 20, scale: 0
      t.string :to
      t.integer :block_number
      t.integer :block_timestamp
      t.string :transaction_hash
      t.integer :status
      t.string :encoded
      t.string :dispatch_transaction_hash
      t.integer :dispatch_block_number
      t.integer :dispatch_block_timestamp
      t.string :clear_transaction_hash
      t.integer :clear_block_number
      t.integer :clear_block_timestamp

      t.timestamps
    end
    add_index :messages, :msg_hash, unique: true
    add_index :messages, :root, unique: true
  end
end
