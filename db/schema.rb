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

ActiveRecord::Schema[7.1].define(version: 2024_01_16_072632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pug_evm_contracts", force: :cascade do |t|
    t.integer "network_id"
    t.string "address"
    t.string "name"
    t.string "abi_file"
    t.string "creator"
    t.integer "creation_block"
    t.string "creation_tx_hash"
    t.datetime "creation_timestamp"
    t.integer "last_scanned_block"
    t.string "tron_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_id", "address"], name: "index_pug_evm_contracts_on_network_id_and_address", unique: true
  end

  create_table "pug_evm_logs", force: :cascade do |t|
    t.integer "network_id"
    t.integer "evm_contract_id"
    t.string "address"
    t.text "data"
    t.string "block_hash"
    t.integer "block_number"
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
    t.integer "evm_transaction_id"
    t.index ["decoded"], name: "index_pug_evm_logs_on_decoded", using: :gin
    t.index ["event_name"], name: "index_pug_evm_logs_on_event_name"
    t.index ["network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_network_id_block_number_transaction_index_lo_603ca303c9", unique: true
    t.index ["network_id"], name: "index_pug_evm_logs_on_network_id"
    t.index ["topic0"], name: "index_pug_evm_logs_on_topic0"
    t.index ["topic1"], name: "index_pug_evm_logs_on_topic1"
    t.index ["topic2"], name: "index_pug_evm_logs_on_topic2"
    t.index ["topic3"], name: "index_pug_evm_logs_on_topic3"
  end

  create_table "pug_evm_transactions", force: :cascade do |t|
    t.integer "evm_contract_id"
    t.integer "network_id"
    t.string "block_hash"
    t.string "block_number"
    t.string "chain_id"
    t.string "from"
    t.string "to"
    t.string "value"
    t.string "gas"
    t.string "gas_price"
    t.string "transaction_hash"
    t.text "input"
    t.string "max_priority_fee_per_gas"
    t.string "max_fee_per_gas"
    t.string "nonce"
    t.string "r"
    t.string "s"
    t.string "v"
    t.string "transaction_index"
    t.string "transaction_type"
    t.index ["network_id", "transaction_hash"], name: "index_pug_evm_transactions_on_network_id_and_transaction_hash", unique: true
  end

  create_table "pug_networks", force: :cascade do |t|
    t.bigint "chain_id"
    t.string "name"
    t.string "display_name"
    t.string "rpc"
    t.string "explorer"
    t.integer "scan_span", default: 2000
    t.integer "last_scanned_block", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pug_oracle_v2_assigneds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "f_msg_hash"
    t.decimal "f_fee", precision: 78
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_v2_assigneds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_v2_assigneds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_16b1ebb8c4", unique: true
    t.index ["pug_network_id", "f_fee"], name: "index_pug_oracle_v2_assigneds_on_pug_network_id_and_f_fee"
    t.index ["pug_network_id", "f_msg_hash"], name: "index_pug_oracle_v2_assigneds_on_pug_network_id_and_f_msg_hash"
    t.index ["pug_network_id"], name: "index_pug_oracle_v2_assigneds_on_pug_network_id"
  end

  create_table "pug_oracle_v2_impored_message_roots", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "f_chaind_id", precision: 78
    t.decimal "f_block_number", precision: 78
    t.string "f_message_root"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_6d2e195909"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_v2_impored_message_roots_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_9daf6792a0", unique: true
    t.index ["pug_network_id", "f_block_number"], name: "idx_on_pug_network_id_f_block_number_1ca2705196"
    t.index ["pug_network_id", "f_chaind_id"], name: "idx_on_pug_network_id_f_chaind_id_901d3b5e98"
    t.index ["pug_network_id", "f_message_root"], name: "idx_on_pug_network_id_f_message_root_23c0deb29f"
    t.index ["pug_network_id"], name: "index_pug_oracle_v2_impored_message_roots_on_pug_network_id"
  end

  create_table "pug_oracle_v2_set_approveds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "f_operator"
    t.boolean "f_approve"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_v2_set_approveds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_v2_set_approveds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_88ecc5c162", unique: true
    t.index ["pug_network_id", "f_approve"], name: "idx_on_pug_network_id_f_approve_65e5267bb9"
    t.index ["pug_network_id", "f_operator"], name: "idx_on_pug_network_id_f_operator_7574b4c4bc"
    t.index ["pug_network_id"], name: "index_pug_oracle_v2_set_approveds_on_pug_network_id"
  end

  create_table "pug_oracle_v2_set_fees", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_fee", precision: 78
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_v2_set_fees_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_v2_set_fees_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_7febe4aabe", unique: true
    t.index ["pug_network_id", "f_chain_id"], name: "index_pug_oracle_v2_set_fees_on_pug_network_id_and_f_chain_id"
    t.index ["pug_network_id", "f_fee"], name: "index_pug_oracle_v2_set_fees_on_pug_network_id_and_f_fee"
    t.index ["pug_network_id"], name: "index_pug_oracle_v2_set_fees_on_pug_network_id"
  end

  create_table "pug_ormp_app_config_updateds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "f_ua"
    t.string "f_oracle"
    t.string "f_relayer"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_app_config_updateds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_app_config_updateds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_2b01289eec", unique: true
    t.index ["pug_network_id", "f_oracle"], name: "idx_on_pug_network_id_f_oracle_8323d47ff2"
    t.index ["pug_network_id", "f_relayer"], name: "idx_on_pug_network_id_f_relayer_c71a351d14"
    t.index ["pug_network_id", "f_ua"], name: "index_pug_ormp_app_config_updateds_on_pug_network_id_and_f_ua"
    t.index ["pug_network_id"], name: "index_pug_ormp_app_config_updateds_on_pug_network_id"
  end

  create_table "pug_ormp_default_config_updateds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "f_oracle"
    t.string "f_relayer"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_default_config_updateds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_default_config_updateds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_cb012d1d77", unique: true
    t.index ["pug_network_id", "f_oracle"], name: "idx_on_pug_network_id_f_oracle_aab749a0b0"
    t.index ["pug_network_id", "f_relayer"], name: "idx_on_pug_network_id_f_relayer_cb3deb1a0f"
    t.index ["pug_network_id"], name: "index_pug_ormp_default_config_updateds_on_pug_network_id"
  end

  create_table "pug_ormp_message_accepteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
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
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_message_accepteds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_message_accepteds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_7c0e6d0e21", unique: true
    t.index ["pug_network_id", "f_message_channel"], name: "idx_on_pug_network_id_f_message_channel_c7d7cafae5"
    t.index ["pug_network_id", "f_message_encoded"], name: "idx_on_pug_network_id_f_message_encoded_e680a98889"
    t.index ["pug_network_id", "f_message_from"], name: "idx_on_pug_network_id_f_message_from_e9674975f6"
    t.index ["pug_network_id", "f_message_from_chain_id"], name: "idx_on_pug_network_id_f_message_from_chain_id_d3d4ab4794"
    t.index ["pug_network_id", "f_message_gas_limit"], name: "idx_on_pug_network_id_f_message_gas_limit_dc92bc0748"
    t.index ["pug_network_id", "f_message_index"], name: "idx_on_pug_network_id_f_message_index_262dbe7376"
    t.index ["pug_network_id", "f_message_to"], name: "idx_on_pug_network_id_f_message_to_573d2b18b7"
    t.index ["pug_network_id", "f_message_to_chain_id"], name: "idx_on_pug_network_id_f_message_to_chain_id_46f0a711be"
    t.index ["pug_network_id", "f_msg_hash"], name: "idx_on_pug_network_id_f_msg_hash_ab646ea66a"
    t.index ["pug_network_id", "f_root"], name: "index_pug_ormp_message_accepteds_on_pug_network_id_and_f_root"
    t.index ["pug_network_id"], name: "index_pug_ormp_message_accepteds_on_pug_network_id"
  end

  create_table "pug_ormp_message_dispatcheds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "f_msg_hash"
    t.boolean "f_dispatch_result"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_3352e95027", unique: true
    t.index ["pug_network_id", "f_dispatch_result"], name: "idx_on_pug_network_id_f_dispatch_result_04d02f7961"
    t.index ["pug_network_id", "f_msg_hash"], name: "idx_on_pug_network_id_f_msg_hash_6bdc0869a2"
    t.index ["pug_network_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_network_id"
  end

  create_table "pug_relayer_assigneds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "f_msg_hash"
    t.decimal "f_fee", precision: 78
    t.string "f_params"
    t.string "f_proof"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_assigneds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_assigneds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_2665d02ebb", unique: true
    t.index ["pug_network_id", "f_fee"], name: "index_pug_relayer_assigneds_on_pug_network_id_and_f_fee"
    t.index ["pug_network_id", "f_msg_hash"], name: "index_pug_relayer_assigneds_on_pug_network_id_and_f_msg_hash"
    t.index ["pug_network_id", "f_params"], name: "index_pug_relayer_assigneds_on_pug_network_id_and_f_params"
    t.index ["pug_network_id", "f_proof"], name: "index_pug_relayer_assigneds_on_pug_network_id_and_f_proof"
    t.index ["pug_network_id"], name: "index_pug_relayer_assigneds_on_pug_network_id"
  end

  create_table "pug_relayer_set_approveds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "f_operator"
    t.boolean "f_approve"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_approveds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_approveds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_4fe6ff52a8", unique: true
    t.index ["pug_network_id", "f_approve"], name: "idx_on_pug_network_id_f_approve_30662fe56b"
    t.index ["pug_network_id", "f_operator"], name: "idx_on_pug_network_id_f_operator_185b111111"
    t.index ["pug_network_id"], name: "index_pug_relayer_set_approveds_on_pug_network_id"
  end

  create_table "pug_relayer_set_dst_configs", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_base_gas", precision: 20
    t.decimal "f_gas_per_byte", precision: 20
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_dst_configs_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_dst_configs_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_a7731c62b7", unique: true
    t.index ["pug_network_id", "f_base_gas"], name: "idx_on_pug_network_id_f_base_gas_968a4a0c4c"
    t.index ["pug_network_id", "f_chain_id"], name: "idx_on_pug_network_id_f_chain_id_59712fd840"
    t.index ["pug_network_id", "f_gas_per_byte"], name: "idx_on_pug_network_id_f_gas_per_byte_8a0550a98b"
    t.index ["pug_network_id"], name: "index_pug_relayer_set_dst_configs_on_pug_network_id"
  end

  create_table "pug_relayer_set_dst_prices", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "f_chain_id", precision: 78
    t.decimal "f_dst_price_ratio", precision: 39
    t.decimal "f_dst_gas_price_in_wei", precision: 39
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_dst_prices_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_dst_prices_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_a19fe34800", unique: true
    t.index ["pug_network_id", "f_chain_id"], name: "idx_on_pug_network_id_f_chain_id_23efe09e2e"
    t.index ["pug_network_id", "f_dst_gas_price_in_wei"], name: "idx_on_pug_network_id_f_dst_gas_price_in_wei_ca6d38d091"
    t.index ["pug_network_id", "f_dst_price_ratio"], name: "idx_on_pug_network_id_f_dst_price_ratio_c9ca0d8862"
    t.index ["pug_network_id"], name: "index_pug_relayer_set_dst_prices_on_pug_network_id"
  end

  add_foreign_key "pug_oracle_v2_assigneds", "pug_evm_contracts"
  add_foreign_key "pug_oracle_v2_assigneds", "pug_evm_logs"
  add_foreign_key "pug_oracle_v2_assigneds", "pug_networks"
  add_foreign_key "pug_oracle_v2_impored_message_roots", "pug_evm_contracts"
  add_foreign_key "pug_oracle_v2_impored_message_roots", "pug_evm_logs"
  add_foreign_key "pug_oracle_v2_impored_message_roots", "pug_networks"
  add_foreign_key "pug_oracle_v2_set_approveds", "pug_evm_contracts"
  add_foreign_key "pug_oracle_v2_set_approveds", "pug_evm_logs"
  add_foreign_key "pug_oracle_v2_set_approveds", "pug_networks"
  add_foreign_key "pug_oracle_v2_set_fees", "pug_evm_contracts"
  add_foreign_key "pug_oracle_v2_set_fees", "pug_evm_logs"
  add_foreign_key "pug_oracle_v2_set_fees", "pug_networks"
  add_foreign_key "pug_ormp_app_config_updateds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_app_config_updateds", "pug_evm_logs"
  add_foreign_key "pug_ormp_app_config_updateds", "pug_networks"
  add_foreign_key "pug_ormp_default_config_updateds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_default_config_updateds", "pug_evm_logs"
  add_foreign_key "pug_ormp_default_config_updateds", "pug_networks"
  add_foreign_key "pug_ormp_message_accepteds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_message_accepteds", "pug_evm_logs"
  add_foreign_key "pug_ormp_message_accepteds", "pug_networks"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_evm_logs"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_networks"
  add_foreign_key "pug_relayer_assigneds", "pug_evm_contracts"
  add_foreign_key "pug_relayer_assigneds", "pug_evm_logs"
  add_foreign_key "pug_relayer_assigneds", "pug_networks"
  add_foreign_key "pug_relayer_set_approveds", "pug_evm_contracts"
  add_foreign_key "pug_relayer_set_approveds", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_approveds", "pug_networks"
  add_foreign_key "pug_relayer_set_dst_configs", "pug_evm_contracts"
  add_foreign_key "pug_relayer_set_dst_configs", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_dst_configs", "pug_networks"
  add_foreign_key "pug_relayer_set_dst_prices", "pug_evm_contracts"
  add_foreign_key "pug_relayer_set_dst_prices", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_dst_prices", "pug_networks"
end
