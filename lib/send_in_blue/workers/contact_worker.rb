# require 'sidekiq'

module SendInBlue
  class ContactWorker
    include Sidekiq::Worker

    sidekiq_options retry: 7

    attr_accessor :contact

    def perform(contact_id, action)
      @contact = SendInBlue.config.contact_model.find(contact_id)

      send action
    rescue SibApiV3Sdk::ApiError => e
      raise SendInBlue::Error, "Error when calling SendInBlue ContactsApi.#{action} for #{contact_id}: #{e}"
    end

    private

    def api_instance
      @api_instance ||= SibApiV3Sdk::ContactsApi.new
    end

    def create
      res = SendInBlue::API.create_contact(contact)
    end

    def update
      res = SendInBlue::API.update_contact(contact)
    end

    def delete
      res = SendInBlue::API.delete_contact(contact)
    end
  end
end
