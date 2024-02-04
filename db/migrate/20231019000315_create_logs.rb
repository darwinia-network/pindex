class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :address
      t.text :data
      t.string :block_hash
      t.bigint :block_number
      t.string :transaction_hash
      t.integer :transaction_index
      t.integer :log_index
      t.integer :timestamp
      t.string :topic0
      t.string :topic1
      t.string :topic2
      t.string :topic3
      # decoded
      t.string :event_name
      t.jsonb :decoded

      t.timestamps
    end

    add_index :logs, %i[chain_id block_number transaction_index log_index], unique: true
    add_index :logs, :chain_id
    add_index :logs, :address
    add_index :logs, :block_hash
    add_index :logs, :topic0
    add_index :logs, :topic1
    add_index :logs, :topic2
    add_index :logs, :topic3

    # For decoded data query
    add_index :logs, :event_name
    add_index :logs, :decoded, using: :gin # http://www.pgsql.tech/article_104_10000050
  end
end
