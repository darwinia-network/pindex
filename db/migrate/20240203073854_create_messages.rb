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
      t.bigint :block_number
      t.datetime :block_timestamp
      t.string :transaction_hash
      t.integer :status
      t.text :encoded
      t.string :dispatch_transaction_hash
      t.bigint :dispatch_block_number
      t.datetime :dispatch_block_timestamp
      t.jsonb :proof
      t.decimal :gas_limit, precision: 78, scale: 0
      t.text :msgport_payload
      t.string :msgport_from
      t.string :msgport_to

      t.timestamps
    end
    add_index :messages, :msg_hash, unique: true
    add_index :messages, :root, unique: true
  end
end
