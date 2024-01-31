class Contract
  attr_reader :network, :name, :address, :abi, :raw_abi, :start_block

  def initialize(network, name, address, abi, start_block = nil)
    @network = network
    @name = name.to_s
    @address = address.downcase
    @raw_abi = File.read(File.join(Rails.root, abi))
    @abi = JSON.parse(@raw_abi)
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

    def find_by_address(network_name, address)
      all.find do |contract|
        contract.network.name.downcase == network_name.downcase &&
          contract.address.downcase == address.downcase
      end
    end

    private

    def _all
      result = []
      Rails.application.config.pug['contracts'].each do |contract_name, contract_config|
        contract_config[:networks].map do |network_config|
          network = Network.find(network_config[:name])
          result << Contract.new(
            network,
            contract_name,
            network_config[:address],
            contract_config[:abi],
            network_config[:start_block]
          )
        end
      end
      result
    end
  end
end
