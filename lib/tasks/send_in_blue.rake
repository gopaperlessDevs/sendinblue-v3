namespace :send_in_blue do
  desc "Adds any send_in_blue contact attributes to the SendInBlue servers, which are currently missing on their servers."
  task sync_contact_attributes_to_remote: :environment do
    sib_contacts_api = SibApiV3Sdk::ContactsApi.new
    result = sib_contacts_api.get_attributes
    remote_attrs = result.attributes.map{ |x| x.name.downcase.to_sym }

    local_attrs = SendInBlue.config.contact_model.send_in_blue_settings[:attributes].dup

    # delete remote_attrs from local_attrs
    remote_attrs.each { |a| local_attrs.delete(a) }

    # create the remaining attrs

    local_attrs.each do |attr|
      puts "Select a type for attr '#{attr}': (T)ext, (D)ate, (N)umber, (B)oolean"
      input = gets.chomp.downcase
      skip = false

      type = case input
      when "t", "text"
        "text"
      when "d", "date"
        "date"
      when "n", "number"
        "number"
      when "b", "boolean"
        "boolean"
      else
        puts "Unrecognised type! Attribute will not be created."
        skip = true
      end

      next if skip
      puts "Creating SendInBlue attribute: [#{attr}: #{type}]!"

    end
  end

  def sib_contacts_api
    @contact_api ||= SibApiV3Sdk::ContactsApi.new
  end

  def sib_attributes_api
    @attributes_api ||= SibApiV3Sdk::AttributesApi.new
  end

  def create

  end
end
