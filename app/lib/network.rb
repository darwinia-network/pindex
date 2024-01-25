class Network
  attr_reader :name, :rpc, :chain_id, :max_scan_range
  attr_accessor :start_block

  def initialize(name, chain_id, rpc, max_scan_range = nil)
    @name = name.to_s
    @chain_id = chain_id
    @rpc = rpc
    @max_scan_range = max_scan_range || 20_000
    @start_block = -1
  end

  class << self
    def all
      @all ||= _all
    end

    def find(name)
      all.find { |network| network.name.downcase == name.downcase }
    end

    private

    def _all
      Rails.application.config.pug['networks'].map do |name, network|
        Network.new(
          name,
          network[:chain_id],
          network[:rpc],
          network[:max_scan_range]
        )
      end
    end
  end
end
