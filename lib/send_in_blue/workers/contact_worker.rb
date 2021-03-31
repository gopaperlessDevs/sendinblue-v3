# require 'sidekiq'

module SendInBlue
  class ContactWorker
    include Sidekiq::Worker

    sidekiq_options retry: 7

    attr_accessor :contact_id

    def perform(contact_id, action)
      @contact_id = contact_id

      send action
    rescue SibApiV3Sdk::ApiError => e
      raise SendInBlue::Error, "Error when calling SendInBlue ContactsApi.#{action} for #{contact_id}: #{e}"
    end

    private

    def api_instance
      @api_instance ||= SibApiV3Sdk::ContactsApi.new
    end

    def create
      res = SendInBlue::API.create_contact(find_contact)
    end

    def update
      res = SendInBlue::API.update_contact(find_contact)
    end

    # @contact_id should be the sib_id
    def delete
      res = SendInBlue::API.delete_contact(@contact_id)
    end

    def find_contact
      SendInBlue.config.contact_model.find(@contact_id)
    end
  end
end
