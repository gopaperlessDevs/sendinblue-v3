namespace :send_in_blue do
  desc "Adds any send_in_blue contact attributes to the SendInBlue servers, which are currently missing on their servers."
  task sync_contact_attributes_to_remote: :environment do
    remote_attrs = SendInBlue::Api.get_attributes.attributes.map { |x| x.name.downcase.to_sym }

    sync_default_attributes(remote_attrs)
    sync_custom_attributes(remote_attrs)
  end

  def sync_default_attributes(remote_attrs)
    default_attrs = SendInBlue.config.contact_model.send_in_blue_default_attributes.dup
    default_attrs.each { |a| local_attrs.delete(a) }

    default_attrs.each do |attr|
      if attr.to_sym == :sib_consent
        puts "Creating SendInBlue attribute: #{attr}!"
        SendInBlue::Api.create_attribute(attr, "boolean")
      if attr.to_sym == :sib_env
        puts "Creating SendInBlue attribute: #{attr}!"
        SendInBlue::Api.create_attribute(attr, "text")
      end
    end
  end

  def sync_custom_attributes(remote_attrs)
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
end
