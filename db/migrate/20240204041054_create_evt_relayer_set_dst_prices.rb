class CreateEvtRelayerSetDstPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :evt_relayer_set_dst_prices do |t|
      t.decimal :f_chain_id, precision: 78, scale: 0
      t.decimal :f_dst_price_ratio, precision: 39, scale: 0
      t.decimal :f_dst_gas_price_in_wei, precision: 39, scale: 0
      t.datetime :timestamp
      t.decimal :block_number, precision: 78, scale: 0
      t.integer :transaction_index
      t.integer :log_index
      t.decimal :chain_id, precision: 20, scale: 0
      t.string :contract_address

      t.timestamps
    end
    add_index :evt_relayer_set_dst_prices, :f_chain_id
    add_index :evt_relayer_set_dst_prices, :f_dst_price_ratio
    add_index :evt_relayer_set_dst_prices, :f_dst_gas_price_in_wei
  end
end
