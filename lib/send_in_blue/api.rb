module SendInBlue
  class API
    class << self
      def create_contact(contact)
        return false unless contact.consents_to_send_in_blue_email?

        contact_data = SibApiV3Sdk::CreateContact.new email: contact.sib_email, attributes: contact.send_in_blue_attributes
        result = nil

        begin
          result = contacts_api.create_contact(contact_data)
        rescue SibApiV3Sdk::ApiError => e
          result = contacts_api.get_contact_info(contact.sib_email)
        end

        contact.update_send_in_blue_id!(result.id)
        result
      end

      # if contact doesnt have sendinblue id and hasnt opeted in, then do nothing
      # if contact doesnt have sendinblue id, then create contact
      #
      # Note: updating email attr only works if email has changed.
      #
      def update_contact(contact)
        return false if !contact.sib_id && !contact.consents_to_send_in_blue_email?
        return create_contact(contact) if !contact.sib_id

        contacts_api.update_contact(
          contact.sib_id,
          SibApiV3Sdk::UpdateContact.new(attributes: contact.send_in_blue_update_attributes)
        )
      end

      def delete_contact(sib_id)
        contacts_api.delete_contact(sib_id)
        # contact.update_send_in_blue_id!(nil) unless contact.destroyed?
      end

      def get_attributes
        contacts_api.get_attributes
      end

      def create_attribute(attr_name, type, category = "normal")
        attr_properties = SibApiV3Sdk::CreateAttribute.new(type: type)

        attributes_api.create_attribute(category, attr_name, attr_properties)
      end

      def delete_attribute(attr_name, category = "normal")
        attributes_api.delete_attribute(category, attr_name)
      end

      private

      def contacts_api
        @contacts_api ||= SibApiV3Sdk::ContactsApi.new
      end

      def attributes_api
        @attributes_api ||= SibApiV3Sdk::AttributesApi.new
      end
    end
  end
end
