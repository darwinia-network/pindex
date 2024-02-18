class CreateBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :blocks do |t|
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :block_hash
      t.bigint :block_number
      t.decimal :base_fee_per_gas, precision: 78, scale: 0
      t.decimal :difficulty, precision: 78, scale: 0
      t.text :extra_data
      t.decimal :gas_limit, precision: 78, scale: 0
      t.decimal :gas_used, precision: 78, scale: 0
      t.string :logs_bloom
      t.string :miner
      t.string :mix_hash
      t.string :nonce
      t.string :parent_hash
      t.string :receipts_root
      t.string :sha3_uncles
      t.decimal :size, precision: 78, scale: 0
      t.string :state_root
      t.integer :timestamp
      t.decimal :total_difficulty, precision: 78, scale: 0
      t.string :transactions_root
    end

    add_index :blocks, %i[chain_id block_hash], unique: true
    add_index :blocks, %i[chain_id block_number], unique: true
    add_index :blocks, :timestamp
  end
end
