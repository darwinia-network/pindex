class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :transaction_hash
      t.string :block_hash
      t.decimal :block_number, precision: 78, scale: 0
      t.string :from
      t.string :to
      t.decimal :value, precision: 78, scale: 0
      t.decimal :gas, precision: 78, scale: 0
      t.decimal :gas_price, precision: 78, scale: 0
      t.text :input
      t.decimal :max_priority_fee_per_gas, precision: 78, scale: 0
      t.decimal :max_fee_per_gas, precision: 78, scale: 0
      t.integer :nonce
      t.string :r
      t.string :s
      t.decimal :v, precision: 78, scale: 0
      t.integer :transaction_index
      t.string :transaction_type
    end

    add_index :transactions, %i[chain_id transaction_hash], unique: true
  end
end
