module HttpJsonRpcClient
  class << self
    attr_accessor :logger, :retry_limit, :retry_interval

    def request(url, method, *params)
      logger.debug "REQUEST: #{method}(#{params.join(', ')})"

      body = build_json_rpc_body(method, params, Time.now.to_i)
      if retry_limit
        do_request_with_retry(url, body, 0)
      else
        do_request(url, body)
      end
    end

    def respond_to_missing?(*_args)
      true
    end

    def method_missing(method, *args)
      # check if the first argument is a url
      url_regex = %r{^https?://}
      raise 'url format is not correct' unless args[0].match?(url_regex)

      url = args[0]
      request(url, method, *args[1..])
    end

    private

    def do_request_with_retry(url, body, tries = 0)
      do_request(url, body)
    rescue StandardError => e
      raise e unless tries < retry_limit

      logger.error e.message
      logger.error "retry after #{retry_interval || 2} seconds..."
      sleep retry_interval || 2
      do_request_with_retry(url, body, tries + 1)
    end

    def do_request(url, body)
      logger.debug "rpc url: #{url}"
      logger.debug "req body: #{body}"
      uri = URI(url)
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = body
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.instance_of? URI::HTTPS
      res = http.request(req)

      raise res.class.name unless res.is_a?(Net::HTTPSuccess)

      logger.debug "res body: #{res.body}"
      result = JSON.parse(res.body)
      raise result['error']['message'] if result['error']

      result['result']
    end

    def build_json_rpc_body(method, params, id)
      {
        'id' => id,
        'jsonrpc' => '2.0',
        'method' => method,
        'params' => params.reject(&:nil?)
      }.to_json
    end
  end
end

HttpJsonRpcClient.logger = Logger.new($stdout)
HttpJsonRpcClient.logger.level = Logger::INFO

# # HttpClient.retry_limit = 3
# p HttpJsonRpcClient.eth_blockNumber('https://crab-rpc.darwinia.network')
# p HttpJsonRpcClient.eth_getLogs(
#   'https://crab-rpc.darwinia.network',
#   {
#     address: '0x00000000001523057a05d6293C1e5171eE33eE0A',
#     topics: ['0x504f152883e6158786ddfcce63f4d4d95ce8e404b1f6e6365a06f63849b7cb95'],
#     fromBlock: '0x' + 1_658_340.to_s(16),
#     toBlock: '0x' + 1_660_340.to_s(16)
#   }
# )
