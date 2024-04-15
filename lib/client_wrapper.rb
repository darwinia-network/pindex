require_relative 'http_json_rpc_client'

# HttpJsonRpcClient.logger = Logger.new($stdout)
# HttpJsonRpcClient.logger.level = Logger::INFO

class RunTooFast < StandardError; end

class ClientWrapper
  def initialize(url)
    @url = url
  end

  # A transaction with a log with topics [A, B] will be matched by the following topic filters:
  #   [] “anything”
  #   [A] “A in first position (and anything after)”
  #   [null, B] “anything in first position AND B in second position (and anything after)”
  #   [A, B] “A in first position AND B in second position (and anything after)”
  #   [[A, B], [A, B]] “(A OR B) in first position AND (A OR B) in second position (and anything after)”
  #
  # From: https://docs.alchemy.com/docs/deep-dive-into-eth_getlogs
  #
  # returns: [logs, last_scanned_block]
  def get_logs(addresses, topics, from_block, block_interval)
    to_block = [(from_block + block_interval - 1), latest_secure_block_number].min

    raise RunTooFast, "[#{from_block} .. #{to_block}]" unless to_block >= from_block

    [
      get_logs_between(addresses, topics, from_block, to_block),
      to_block
    ]
  end

  # require: from_block <= to_block
  def get_logs_between(addresses, topics, from_block, to_block)
    result =
      if topics.nil?
        # p HttpJsonRpcClient.eth_getLogs(
        #   'https://crab-rpc.darwinia.network',
        #   {
        #     address: '0x00000000001523057a05d6293C1e5171eE33eE0A',
        #     fromBlock: '0x' + 1_658_340.to_s(16),
        #     toBlock: '0x' + 1_660_340.to_s(16)
        #   }
        # )

        HttpJsonRpcClient.eth_getLogs(
          @url,
          {
            address: addresses,
            fromBlock: to_hex(from_block),
            toBlock: to_hex(to_block)
          }
        )
      else
        HttpJsonRpcClient.eth_getLogs(
          @url,
          {
            address: addresses,
            topics: [topics],
            fromBlock: to_hex(from_block),
            toBlock: to_hex(to_block)
          }
        )
      end

    result.map { |log| rich(log) }
  end

  def eth_get_transaction_by_hash(transaction_hash)
    HttpJsonRpcClient.eth_getTransactionByHash(@url, transaction_hash)
  end

  def eth_get_block_by_number(block_number, full_tx = false)
    HttpJsonRpcClient.eth_getBlockByNumber(@url, to_hex(block_number), full_tx)
  end

  private

  def latest_secure_block_number
    # HttpJsonRpcClient.eth_blockNumber(@url).to_i(16) - 6
    HttpJsonRpcClient.eth_getBlockByNumber(@url, 'finalized', false)['number'].to_i(16)
  end

  def to_hex(number)
    hex = number.to_s(16)

    "0x#{hex}"
  end

  # result example:
  # [
  #   {
  #     "address"=>"0x000000007e24da6666c773280804d8021e12e13f",
  #     "topics"=>["0xd984ea421ae5d2a473199f85e03998a04a12f54d6f1fa183a955b3df1c0c546d"],
  #     "data"=>"0x0000000000000000000000000b001c95e86d64c1ad6e43944c568a6c31b538870000000000000000000000000000000000000000000000000000000000000001",
  #     "block_hash"=>"0xdf64b1e453e8e1ccf37bfcee435ccc300d33155675db9d653506dd48d15f686f",
  #     "block_number"=>1367206,
  #     "transaction_hash"=>"0x3c9c9c70cb7f451edd8d57bb68f901f7943c46afab512f3a157f26fe7412c48a",
  #     "transaction_index"=>5,
  #     "log_index"=>2,
  #     "transaction_log_index"=>"0x0",
  #     "removed"=>false,
  #     "timestamp"=>1693364784
  #   }
  # ]
  def rich(log)
    # convert hex to decimal
    log['blockNumber'] = log['blockNumber'].to_i(16)
    log['transactionIndex'] = log['transactionIndex'].to_i(16)
    log['logIndex'] = log['logIndex'].to_i(16)

    # add timestamp to log
    block = eth_get_block_by_number(log['blockNumber'])
    log['timestamp'] = block['timestamp'].to_i(16)

    log.transform_keys(&:underscore)
  end
end
