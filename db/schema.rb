# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_04_041054) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.decimal "chain_id", precision: 20
    t.string "block_hash"
    t.bigint "block_number"
    t.decimal "base_fee_per_gas", precision: 78
    t.decimal "difficulty", precision: 78
    t.text "extra_data"
    t.decimal "gas_limit", precision: 78
    t.decimal "gas_used", precision: 78
    t.string "logs_bloom"
    t.string "miner"
    t.string "mix_hash"
    t.string "nonce"
    t.string "parent_hash"
    t.string "receipts_root"
    t.string "sha3_uncles"
    t.decimal "size", precision: 78
    t.string "state_root"
    t.integer "timestamp"
    t.decimal "total_difficulty", precision: 78
    t.string "transactions_root"
    t.index ["chain_id", "block_hash"], name: "index_blocks_on_chain_id_and_block_hash", unique: true
    t.index ["chain_id", "block_number"], name: "index_blocks_on_chain_id_and_block_number", unique: true
    t.index ["timestamp"], name: "index_blocks_on_timestamp"
  end

  create_table "evt_ormp_app_config_updateds", force: :cascade do |t|
    t.string "f_ua"
    t.string "f_oracle"
    t.string "f_relayer"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_oracle"], name: "index_evt_ormp_app_config_updateds_on_f_oracle"
    t.index ["f_relayer"], name: "index_evt_ormp_app_config_updateds_on_f_relayer"
    t.index ["f_ua"], name: "index_evt_ormp_app_config_updateds_on_f_ua"
  end

  create_table "evt_ormp_default_config_updateds", force: :cascade do |t|
    t.string "f_oracle"
    t.string "f_relayer"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_oracle"], name: "index_evt_ormp_default_config_updateds_on_f_oracle"
    t.index ["f_relayer"], name: "index_evt_ormp_default_config_updateds_on_f_relayer"
  end

  create_table "evt_ormp_message_accepteds", force: :cascade do |t|
    t.string "f_msg_hash"
    t.string "f_root"
    t.string "f_message_channel"
    t.decimal "f_message_index", precision: 78
    t.decimal "f_message_from_chain_id", precision: 78
    t.string "f_message_from"
    t.decimal "f_message_to_chain_id", precision: 78
    t.string "f_message_to"
    t.decimal "f_message_gas_limit", precision: 78
    t.string "f_message_encoded"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_message_channel"], name: "index_evt_ormp_message_accepteds_on_f_message_channel"
    t.index ["f_message_encoded"], name: "index_evt_ormp_message_accepteds_on_f_message_encoded"
    t.index ["f_message_from"], name: "index_evt_ormp_message_accepteds_on_f_message_from"
    t.index ["f_message_from_chain_id"], name: "index_evt_ormp_message_accepteds_on_f_message_from_chain_id"
    t.index ["f_message_gas_limit"], name: "index_evt_ormp_message_accepteds_on_f_message_gas_limit"
    t.index ["f_message_index"], name: "index_evt_ormp_message_accepteds_on_f_message_index"
    t.index ["f_message_to"], name: "index_evt_ormp_message_accepteds_on_f_message_to"
    t.index ["f_message_to_chain_id"], name: "index_evt_ormp_message_accepteds_on_f_message_to_chain_id"
    t.index ["f_msg_hash"], name: "index_evt_ormp_message_accepteds_on_f_msg_hash"
    t.index ["f_root"], name: "index_evt_ormp_message_accepteds_on_f_root"
  end

  create_table "evt_ormp_message_dispatcheds", force: :cascade do |t|
    t.string "f_msg_hash"
    t.boolean "f_dispatch_result"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_dispatch_result"], name: "index_evt_ormp_message_dispatcheds_on_f_dispatch_result"
    t.index ["f_msg_hash"], name: "index_evt_ormp_message_dispatcheds_on_f_msg_hash"
  end

  create_table "evt_ormp_oracle_assigneds", force: :cascade do |t|
    t.string "f_msg_hash"
    t.decimal "f_fee", precision: 78
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_fee"], name: "index_evt_ormp_oracle_assigneds_on_f_fee"
    t.index ["f_msg_hash"], name: "index_evt_ormp_oracle_assigneds_on_f_msg_hash"
  end

  create_table "evt_ormp_oracle_imported_message_roots", force: :cascade do |t|
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_message_index", precision: 78
    t.string "f_message_root"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_chain_id"], name: "index_evt_ormp_oracle_imported_message_roots_on_f_chain_id"
    t.index ["f_message_index"], name: "idx_on_f_message_index_c9329bb644"
    t.index ["f_message_root"], name: "index_evt_ormp_oracle_imported_message_roots_on_f_message_root"
  end

  create_table "evt_ormp_oracle_ownership_transferreds", force: :cascade do |t|
    t.string "f_previous_owner"
    t.string "f_new_owner"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_new_owner"], name: "index_evt_ormp_oracle_ownership_transferreds_on_f_new_owner"
    t.index ["f_previous_owner"], name: "idx_on_f_previous_owner_cbd7d54d4e"
  end

  create_table "evt_ormp_oracle_set_approveds", force: :cascade do |t|
    t.string "f_operator"
    t.boolean "f_approve"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_approve"], name: "index_evt_ormp_oracle_set_approveds_on_f_approve"
    t.index ["f_operator"], name: "index_evt_ormp_oracle_set_approveds_on_f_operator"
  end

  create_table "evt_ormp_oracle_set_fees", force: :cascade do |t|
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_fee", precision: 78
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_chain_id"], name: "index_evt_ormp_oracle_set_fees_on_f_chain_id"
    t.index ["f_fee"], name: "index_evt_ormp_oracle_set_fees_on_f_fee"
  end

  create_table "evt_ormp_oracle_withdrawals", force: :cascade do |t|
    t.string "f_to"
    t.decimal "f_amt", precision: 78
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_amt"], name: "index_evt_ormp_oracle_withdrawals_on_f_amt"
    t.index ["f_to"], name: "index_evt_ormp_oracle_withdrawals_on_f_to"
  end

  create_table "evt_relayer_assigneds", force: :cascade do |t|
    t.string "f_msg_hash"
    t.decimal "f_fee", precision: 78
    t.string "f_params"
    t.string "f_proof"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_fee"], name: "index_evt_relayer_assigneds_on_f_fee"
    t.index ["f_msg_hash"], name: "index_evt_relayer_assigneds_on_f_msg_hash"
    t.index ["f_params"], name: "index_evt_relayer_assigneds_on_f_params"
    t.index ["f_proof"], name: "index_evt_relayer_assigneds_on_f_proof"
  end

  create_table "evt_relayer_set_approveds", force: :cascade do |t|
    t.string "f_operator"
    t.boolean "f_approve"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_approve"], name: "index_evt_relayer_set_approveds_on_f_approve"
    t.index ["f_operator"], name: "index_evt_relayer_set_approveds_on_f_operator"
  end

  create_table "evt_relayer_set_dst_configs", force: :cascade do |t|
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_base_gas", precision: 20
    t.decimal "f_gas_per_byte", precision: 20
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_base_gas"], name: "index_evt_relayer_set_dst_configs_on_f_base_gas"
    t.index ["f_chain_id"], name: "index_evt_relayer_set_dst_configs_on_f_chain_id"
    t.index ["f_gas_per_byte"], name: "index_evt_relayer_set_dst_configs_on_f_gas_per_byte"
  end

  create_table "evt_relayer_set_dst_prices", force: :cascade do |t|
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_dst_price_ratio", precision: 39
    t.decimal "f_dst_gas_price_in_wei", precision: 39
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_chain_id"], name: "index_evt_relayer_set_dst_prices_on_f_chain_id"
    t.index ["f_dst_gas_price_in_wei"], name: "index_evt_relayer_set_dst_prices_on_f_dst_gas_price_in_wei"
    t.index ["f_dst_price_ratio"], name: "index_evt_relayer_set_dst_prices_on_f_dst_price_ratio"
  end

  create_table "logs", force: :cascade do |t|
    t.decimal "chain_id", precision: 20
    t.string "address"
    t.text "data"
    t.string "block_hash"
    t.bigint "block_number"
    t.string "transaction_hash"
    t.integer "transaction_index"
    t.integer "log_index"
    t.integer "timestamp"
    t.string "topic0"
    t.string "topic1"
    t.string "topic2"
    t.string "topic3"
    t.string "event_name"
    t.jsonb "decoded"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_logs_on_address"
    t.index ["block_hash"], name: "index_logs_on_block_hash"
    t.index ["chain_id", "block_number", "transaction_index", "log_index"], name: "idx_on_chain_id_block_number_transaction_index_log__97fc6714cc", unique: true
    t.index ["chain_id"], name: "index_logs_on_chain_id"
    t.index ["decoded"], name: "index_logs_on_decoded", using: :gin
    t.index ["event_name"], name: "index_logs_on_event_name"
    t.index ["topic0"], name: "index_logs_on_topic0"
    t.index ["topic1"], name: "index_logs_on_topic1"
    t.index ["topic2"], name: "index_logs_on_topic2"
    t.index ["topic3"], name: "index_logs_on_topic3"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "index"
    t.string "msg_hash"
    t.string "root"
    t.string "channel"
    t.decimal "from_chain_id", precision: 20
    t.string "from"
    t.decimal "to_chain_id", precision: 20
    t.string "to"
    t.bigint "block_number"
    t.datetime "block_timestamp"
    t.string "transaction_hash"
    t.integer "status"
    t.text "encoded"
    t.string "dispatch_transaction_hash"
    t.bigint "dispatch_block_number"
    t.datetime "dispatch_block_timestamp"
    t.jsonb "proof"
    t.decimal "gas_limit", precision: 78
    t.text "msgport_payload"
    t.string "msgport_from"
    t.string "msgport_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["msg_hash"], name: "index_messages_on_msg_hash", unique: true
    t.index ["root"], name: "index_messages_on_root", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "chain_id", precision: 20
    t.string "transaction_hash"
    t.string "block_hash"
    t.bigint "block_number"
    t.string "from"
    t.string "to"
    t.decimal "value", precision: 78
    t.decimal "gas", precision: 78
    t.decimal "gas_price", precision: 78
    t.text "input"
    t.decimal "max_priority_fee_per_gas", precision: 78
    t.decimal "max_fee_per_gas", precision: 78
    t.integer "nonce"
    t.string "r"
    t.string "s"
    t.decimal "v", precision: 78
    t.integer "transaction_index"
    t.string "transaction_type"
    t.index ["chain_id", "transaction_hash"], name: "index_transactions_on_chain_id_and_transaction_hash", unique: true
  end

end
