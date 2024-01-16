class CreatePugOrmpAppConfigUpdateds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_app_config_updateds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :f_ua
      t.string :f_oracle
      t.string :f_relayer
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_ormp_app_config_updateds, [:pug_network_id, :f_ua]
    add_index :pug_ormp_app_config_updateds, [:pug_network_id, :f_oracle]
    add_index :pug_ormp_app_config_updateds, [:pug_network_id, :f_relayer]
    add_index :pug_ormp_app_config_updateds, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
