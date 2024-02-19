module ApplicationHelper
  def short(hex)
    "#{hex[0..5]}..#{hex[-4..]}"
  end

  def md_short(hex)
    "#{hex[0..6]}..#{hex[-5..]}"
  end

  def address_link_short(network, address)
    display = Contract.find_by_address(network.chain_id, address)&.name || short(address)
    url = File.join(network.explorer, 'address', address)
    %(<a href="#{url}" class="underline" target="_blank">#{display}</a>).html_safe
  end

  def transaction_link(network, tx_hash)
    url = File.join(network.explorer, 'tx', tx_hash)
    %(<a href="#{url}" class="underline" target="_blank">#{tx_hash}</a>).html_safe
  end

  def block_link(network, block_number)
    url = File.join(network.explorer, 'block', block_number.to_s)
    %(<a href="#{url}" class="underline" target="_blank">#{block_number}</a>).html_safe
  end

  def from_link(message)
    network = message.from_network

    if message.msgport_from
      source_ea = message.msgport_from
      source_ua = message.from
      ea_url = File.join(network.explorer, 'address', source_ea)
      ua_url = File.join(network.explorer, 'address', source_ua)

      contract = Contract.find_by_address(network.chain_id, message.from)
      name = contract ? "(#{contract.name})" : nil
      %(
        <a href="#{ea_url}" class="underline" target="_blank">#{source_ea}</a><br>
        ╰╴<a href="#{ua_url}" class="underline" target="_blank">#{"#{source_ua}#{name || ''}"}</a>
      ).html_safe
    else
      display = message.from
      url = File.join(network.explorer, 'address', message.from)
      %(<a href="#{url}" class="underline" target="_blank">#{display}</a>).html_safe
    end
  end

  def to_link(message)
    network = message.to_network

    if message.msgport_to
      target_ua = message.to
      target_ea = message.msgport_to
      ua_url = File.join(network.explorer, 'address', target_ua)
      ea_url = File.join(network.explorer, 'address', target_ea)
      contract = Contract.find_by_address(network.chain_id, message.from)
      name = contract ? "(#{contract.name})" : nil
      %(
        <a href="#{ua_url}" class="underline" target="_blank">#{target_ua}#{name || ''}</a><br>
        ╰╴<a href="#{ea_url}" class="underline" target="_blank">#{target_ea}</a>
      ).html_safe
    else
      display = message.to
      url = File.join(network.explorer, 'address', message.to)
      %(<a href="#{url}" class="underline" target="_blank">#{display}</a>).html_safe
    end
  end
end
