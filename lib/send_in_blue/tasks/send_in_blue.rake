namespace :send_in_blue do
  desc "Adds any send_in_blue contact attributes to the SendInBlue servers, which are currently missing on their servers."
  task sync_contact_attributes_to_remote: :environment do
    remote_attrs = SendInBlue::Api.get_attributes.attributes.map { |x| x.name.downcase.to_sym }
    local_attrs = SendInBlue.config.contact_model.send_in_blue_settings[:attributes].dup

    remote_attrs.each { |a| local_attrs.delete(a) }

    local_attrs.each do |attr|
      puts "Select a type for attr '#{attr}': (T)ext, (D)ate, (N)umber, (B)oolean"
      input = gets.chomp.downcase

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
        next
      end

      type = type.to_s
      puts "Creating SendInBlue attribute: [#{attr}: #{type}]!"

      SendInBlue::Api.create_attribute(attr, type)
    end
  end

  def sib_contacts_api
    @contact_api ||= SibApiV3Sdk::ContactsApi.new
  end

  def sib_attributes_api
    @attributes_api ||= SibApiV3Sdk::AttributesApi.new
  end
end
