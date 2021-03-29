# frozen_string_literal: true

module SendInBlue
  module Contact
    extend ActiveSupport::Concern

    included do
      class_attribute :send_in_blue_settings, instance_writer: false, default: { attributes: [], id_field: :id }

      after_save :update_send_in_blue_contact
      after_destroy :delete_send_in_blue_contact
    end

    class_methods do
      def send_in_blue_attributes(*args)
        self.send_in_blue_settings[:attributes] = args
      end

      def send_in_blue_id(id_field)
        raise SendInBlue::Error, "Must set send_in_blue_id on the SendInBlue Contact model" if id_field.blank?
        raise SendInBlue::Error, "send_in_blue_id cannot be main id field!" if id.to_sym == :id

        self.send_in_blue_settings[:id_field] = id_field
      end
    end

    def update_send_in_blue_id!(sib_id)
      contact.update! { contact.send_in_blue_settings[:id_field] => sib_id }
    end

    private

    def send_in_blue_attributes
      slice *self.class.send_in_blue_settings[:attributes]
    end

    def update_send_in_blue_contact
      SendInBlue::ContactWorker.perform_async(id, :update)
    end

    def delete_send_in_blue_contact
      SendInBlue::ContactWorker.perform_async(id, :delete)
    end
  end
end
