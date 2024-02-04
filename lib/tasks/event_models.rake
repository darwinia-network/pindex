namespace :event_models do
  desc 'Generate event models'
  task generate: :environment do
    Contract.all.group_by(&:name).each do |contract_name, contracts|
      contract = contracts.first

      events = JSON.parse(contract.raw_abi).select { |abi| abi['type'] == 'event' }
      events.each do |event|
        model_name = Event.model_name(contract_name, event['name'])
        fields = Event.rails_fields_of_event(event)

        Event.generate_model(model_name, fields)
      end
    end
  end
end

module Event
  class << self
    def generate_model(model_name, fields)
      fields_str = fields.map { |f| "#{f[0]}:#{f[1]}:index" }.join(' ')

      if Evt.const_defined?(model_name)
        puts "Model already exists: Evt::#{model_name}"
      else
        unless Rails.root.join('app', 'models', 'evt', "#{model_name.underscore}.rb").exist?
          belongs_to_str = 'chain_id:decimal{20,0} contract_address:string'
          extra_columns_str = 'timestamp:datetime block_number:decimal{78,0} transaction_index:integer log_index:integer'

          columns_str = "#{fields_str} #{extra_columns_str} #{belongs_to_str}"
          system("./bin/rails g model Evt::#{model_name} #{columns_str} --migration --no-test-framework --skip")
        end
      end
    end

    def model_name(contract_name, event_name)
      model_name = "#{contract_name.underscore}_#{event_name.underscore}"
      model_name = "#{shorten(contract_name.underscore)}_#{event_name.underscore}" if model_name.pluralize.length > 63
      model_name.singularize.camelize
    end

    def rails_fields_of_event(event_abi, prefix = 'f')
      event_decoder = EventDecoder.new(event_abi)

      sep = '_'
      flatten_fields = event_decoder.indexed_topic_fields + event_decoder.data_fields_flatten(sep:)
      flatten_fields.map do |field|
        if prefix.present?
          ["#{prefix}#{sep}#{field[0]}", to_rails_type(field[1])]
        else
          [field[0], to_rails_type(field[1])]
        end
      end
    end

    private

    def to_rails_type(abi_type)
      if abi_type == 'address'
        'string'
      elsif abi_type == 'bool'
        'boolean'
      elsif abi_type == 'uint256'
        'decimal{78,0}'
      elsif abi_type == 'uint128'
        'decimal{39,0}'
      elsif abi_type == 'uint64'
        'decimal{20,0}'
      elsif abi_type =~ /int\d+/
        'bigint'
      elsif abi_type =~ /bytes\d*/
        'string'
      else
        abi_type
      end
    end

    def shorten(string)
      words = string.split('_')
      words.map { |word| word[0] }.join('')
    end
  end
end
