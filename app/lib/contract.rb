class Contract
  attr_reader :network, :name, :address, :abi, :start_block

  def initialize(network, name, address, abi, start_block = nil)
    @network = network
    @name = name.to_s
    @address = address.downcase
    @abi = JSON.parse(File.read(File.join(Rails.root, abi)))
    @start_block = start_block || 0
  end
end

class Contract
  class << self
    def all
      @all ||= _all
    end

    def find(network_name, name)
      all.find do |contract|
        contract.network.name.downcase == network_name.downcase &&
          contract.name.downcase == name.downcase
      end
    end

    private

    def _all
      result = []
      Rails.application.config.pug['contracts'].each do |name, contract|
        contract[:networks].map do |n|
          network = Network.find(n[:name])
          network.start_block = n[:start_block] if network.start_block == -1 || n[:start_block] < network.start_block

          result << Contract.new(
            network,
            name,
            n[:address],
            contract[:abi],
            n[:start_block]
          )
        end
      end
      result
    end
  end
end
