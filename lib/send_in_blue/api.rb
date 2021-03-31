module SendInBlue
  class Api
    class << self
      def create_contact(contact)
        contact_data = SibApiV3Sdk::CreateContact.new email: contact.email, attributes: contact.send_in_blue_attributes

        result = contacts_api.create_contact(contact_data)

        contact.update_send_in_blue_id!(JSON.parse(res)["id"])
        result
      end

      def update_contact(contact)
        # if contact doesnt have sendinblue id, then create contact
        return create_contact(contact) unless contact.contact_send_in_blue_id
        return false unless contact.consents_to_send_in_blue_email?

        contacts_api.update_contact(
          contact.contact_send_in_blue_id,
          SibApiV3Sdk::UpdateContact.new(contact.send_in_blue_attributes)
        )
      end

      def delete_contact(contact)
        contacts_api.delete_contact(contact.contact_send_in_blue_id)
      end

      delegate :get_attributes, to: :contacts_api

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
