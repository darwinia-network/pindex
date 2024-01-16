puts '== Start seeding'

# https://chainid.network/chains.json
############################################
# Crab
############################################
# puts '-- Create crab and its contracts'
#
# chain_id = 44
# name = 'crab'
# display_name = 'Crab Network'
# rpc = 'https://crab-rpc.darwinia.network'
# explorer = 'https://crab.subscan.io'
# crab = Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 1000)
#
# # ORMP
# Pug::EvmContract.create(
#   network: crab,
#   address: '0x00000000001523057a05d6293C1e5171eE33eE0A',
#   name: 'ORMP',
#   abi_file: 'public/abis/ORMP-0b90c75f42.json',
#   creator: '0x0f14341a7f464320319025540e8fe48ad0fe5aec',
#   creation_block: 1_658_340,
#   creation_tx_hash: '0x387fc795d596867b56ac5653d98079312030ea86801cdfb7ced22984b9f54844',
#   creation_timestamp: DateTime.new(2023, 11, 7, 11, 7, 0, '+0'),
#   last_scanned_block: 1_658_340
# )
# crab.update(last_scanned_block: 1_658_340)

############################################
# Shasta
############################################
puts '-- Create shasta and its contracts'
shasta = Pug::Network.create(
  chain_id: 2_494_104_990,
  name: 'tron_shasta',
  display_name: 'Tron Shasta',
  rpc: 'https://api.shasta.trongrid.io/jsonrpc',
  explorer: 'https://shasta.tronscan.org',
  scan_span: 50_000
)

# ORMP
Pug::EvmContract.create(
  network: shasta,
  address: "0x#{Pug::TronAddress.base58check_to_hex('TXzW7Zo6CNAS2c6VKJx1xpfeGxcshQGHMm')}",
  tron_address: 'TXzW7Zo6CNAS2c6VKJx1xpfeGxcshQGHMm',
  name: 'ORMP',
  abi_file: 'public/abis/ORMP-0b90c75f42.json',
  creator: "0x#{Pug::TronAddress.base58check_to_hex('THDgXz27GiRQSduXRcNPCEQW7oAu7h6LUQ')}",
  creation_block: 39_683_259,
  creation_tx_hash: '0x26b840544c55c4abf0893069d153dec7a9573e61996e3de9d40c0785bb3ae858',
  creation_timestamp: DateTime.new(2023, 12, 13, 3, 28, 48, '+0'),
  last_scanned_block: 39_683_259
)
puts 'Tron Shasta Contract `ORMP` created'

# OracleV2
Pug::EvmContract.create(
  network: shasta,
  address: "0x#{Pug::TronAddress.base58check_to_hex('TDACQR5FUtNpuBS2g85WKiucvrAWhY6zzs')}",
  tron_address: 'TDACQR5FUtNpuBS2g85WKiucvrAWhY6zzs',
  name: 'OracleV2',
  abi_file: 'public/abis/OracleV2-009aba5a15.json',
  creator: "0x#{Pug::TronAddress.base58check_to_hex('THDgXz27GiRQSduXRcNPCEQW7oAu7h6LUQ')}",
  creation_block: 40_292_754,
  creation_tx_hash: '0x4c106856775aae664a155f7d0afd5cd64409cc8eb37b7c45899adbb48772fff6',
  creation_timestamp: DateTime.new(2024, 1, 3, 12, 31, 21, '+0'),
  last_scanned_block: 40_292_754
)
puts 'Tron Shasta Contract `OracleV2` created'

# Relayer
Pug::EvmContract.create(
  network: shasta,
  address: "0x#{Pug::TronAddress.base58check_to_hex('TXoHifzQNtyfhGckxK4ZHp9w7yim8iZXZ8')}",
  tron_address: 'TXoHifzQNtyfhGckxK4ZHp9w7yim8iZXZ8',
  name: 'Relayer',
  abi_file: 'public/abis/Relayer-5bf71a6102.json',
  creator: "0x#{Pug::TronAddress.base58check_to_hex('THDgXz27GiRQSduXRcNPCEQW7oAu7h6LUQ')}",
  creation_block: 39_683_783,
  creation_tx_hash: '0x785cc411f7d8f09ca2d359961f9e487a8b15fd0ab81c7fb5976e6fc8084328fa',
  creation_timestamp: DateTime.new(2023, 12, 13, 3, 55, 12, '+0'),
  last_scanned_block: 39_683_783
)
puts 'Tron Shasta Contract `Relayer` created'

shasta.update(last_scanned_block: 39_683_259)
