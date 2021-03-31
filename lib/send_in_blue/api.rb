module SendInBlue
  class Api
    class << self
      def get_attributes
        contacts_api.get_attributes
      end

      def delete_attribute(category, attribute_name)
        attributes_api.delete_attribute(category, attribute_name)
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
