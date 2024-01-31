class Contract
  attr_reader :network, :name, :address, :abi, :raw_abi, :start_block

  def initialize(network, name, address, abi, start_block = nil)
    @network = network
    @name = name.to_s
    @address = address.downcase
    @raw_abi = File.read(File.join(Rails.root, abi))
    @abi = Eth::Contract.from_abi(abi: @raw_abi, address: @address, name: @name)
    @start_block = start_block || 0
  end

  def raw_event_abi(name_or_signature)
    name = event_name(name_or_signature)
    JSON.parse(@raw_abi).find do |item|
      item['type'] == 'event' && item['name'] == name
    end
  end

  def event_abi(name_or_signature)
    if hex? name_or_signature
      @abi.events.find do |event|
        event.signature == remove_0x(name_or_signature)
      end
    else
      parsed_abi.events.find do |event|
        event.name == name_or_signature
      end
    end
  end

  def event_name(name_or_signature)
    event_abi(name_or_signature).name
  end

  private

  def hex?(str)
    str = remove_0x(str)

    str.chars.all? { |c| c =~ /[a-fA-F0-9]/ }
  end

  def remove_0x(str)
    if str.start_with?('0x')
      str[2..]
    else
      str
    end
  end
end

class Contract
  class << self
    def all
      @all ||= _all
    end

    def find(network_name_or_chain_id, name)
      if network_name_or_chain_id.is_a? Integer
        all.find do |contract|
          contract.network.chain_id == network_name_or_chain_id &&
            contract.name.downcase == name.downcase
        end
      else
        all.find do |contract|
          contract.network.name.downcase == network_name_or_chain_id.downcase &&
            contract.name.downcase == name.downcase
        end
      end
    end

    def find_by_address(network_name_or_chain_id, address)
      if network_name_or_chain_id.is_a? Integer
        all.find do |contract|
          contract.network.chain_id == network_name_or_chain_id &&
            contract.address.downcase == address.downcase
        end
      else
        all.find do |contract|
          contract.network.name.downcase == network_name_or_chain_id.downcase &&
            contract.address.downcase == address.downcase
        end
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
