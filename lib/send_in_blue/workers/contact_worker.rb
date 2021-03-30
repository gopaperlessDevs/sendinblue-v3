# require 'sidekiq'

class SendInBlue::ContactWorker
  include Sidekiq::Worker

  attr_accessor :contact

  def perform(contact_id, action)
    @contact = SendInBlue.config.contact_model.find(contact_id)

    send :action
  rescue SibApiV3Sdk::ApiError => e
    raise SendInBlue::Error, "Error when calling SendInBlue ContactsApi.#{action} for #{contact_id}: #{e}"
  end

  private

  def api_instance
    @api_instance ||= SibApiV3Sdk::ContactsApi.new
  end

  def create
    res = api_instance.create_contact(SibApiV3Sdk::CreateContact.new(contact.send_in_blue_attributes))

    contact.update_send_in_blue_id!(JSON.parse(res)["id"])
  end

  def update
    # if contact doesnt have sendinblue id, then create contact
    return create unless contact.contact_send_in_blue_id
    return false unless contact.consents_to_send_in_blue_email?

    api_instance.update_contact(
      contact.contact_send_in_blue_id,
      SibApiV3Sdk::UpdateContact.new(contact.send_in_blue_attributes)
    )
  end

  def delete
    api_instance.delete_contact(contact.contact_send_in_blue_id)
  end
end
