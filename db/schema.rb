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

ActiveRecord::Schema[7.1].define(version: 2024_01_25_152016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.decimal "chain_id", precision: 20
    t.string "block_hash"
    t.decimal "block_number", precision: 78
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
    t.decimal "timestamp", precision: 78
    t.decimal "total_difficulty", precision: 78
    t.string "transactions_root"
    t.index ["chain_id", "block_hash"], name: "index_blocks_on_chain_id_and_block_hash", unique: true
    t.index ["chain_id", "block_number"], name: "index_blocks_on_chain_id_and_block_number", unique: true
    t.index ["timestamp"], name: "index_blocks_on_timestamp"
  end

  create_table "evt_oracle_v2_assigneds", force: :cascade do |t|
    t.string "f_msg_hash"
    t.decimal "f_fee", precision: 78
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.index ["f_fee"], name: "index_evt_oracle_v2_assigneds_on_f_fee"
    t.index ["f_msg_hash"], name: "index_evt_oracle_v2_assigneds_on_f_msg_hash"
  end

  create_table "evt_oracle_v2_imported_message_roots", force: :cascade do |t|
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_block_height", precision: 78
    t.string "f_message_root"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.index ["f_block_height"], name: "index_evt_oracle_v2_imported_message_roots_on_f_block_height"
    t.index ["f_chain_id"], name: "index_evt_oracle_v2_imported_message_roots_on_f_chain_id"
    t.index ["f_message_root"], name: "index_evt_oracle_v2_imported_message_roots_on_f_message_root"
  end

  create_table "evt_oracle_v2_set_approveds", force: :cascade do |t|
    t.string "f_operator"
    t.boolean "f_approve"
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.index ["f_approve"], name: "index_evt_oracle_v2_set_approveds_on_f_approve"
    t.index ["f_operator"], name: "index_evt_oracle_v2_set_approveds_on_f_operator"
  end

  create_table "evt_oracle_v2_set_fees", force: :cascade do |t|
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_fee", precision: 78
    t.datetime "timestamp"
    t.decimal "block_number", precision: 78
    t.integer "transaction_index"
    t.integer "log_index"
    t.decimal "chain_id", precision: 20
    t.string "contract_address"
    t.index ["f_chain_id"], name: "index_evt_oracle_v2_set_fees_on_f_chain_id"
    t.index ["f_fee"], name: "index_evt_oracle_v2_set_fees_on_f_fee"
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
    t.index ["f_dispatch_result"], name: "index_evt_ormp_message_dispatcheds_on_f_dispatch_result"
    t.index ["f_msg_hash"], name: "index_evt_ormp_message_dispatcheds_on_f_msg_hash"
  end

  create_table "logs", force: :cascade do |t|
    t.decimal "chain_id", precision: 20
    t.string "address"
    t.text "data"
    t.string "block_hash"
    t.decimal "block_number", precision: 78
    t.string "transaction_hash"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "timestamp"
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

  create_table "transactions", force: :cascade do |t|
    t.decimal "chain_id", precision: 20
    t.string "transaction_hash"
    t.string "block_hash"
    t.decimal "block_number", precision: 78
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
