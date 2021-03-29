# require 'sidekiq'

class SendInBlue::ContactWorker
  include Sidekiq::Worker

  attr_accessor :user, :api_instance

  def perform(user_id, action)
    @user = User.find(user_id)

    send :action
  rescue SibApiV3Sdk::ApiError => e
    raise SendInBlue::Error.new("Error when calling SendInBlue ContactsApi.#{action} for #{user_id}: #{e}"
  end

  private

  def api_instance
    @api_instance = SibApiV3Sdk::ContactsApi.new
  end

  def create
    api_instance.create_contact(SibApiV3Sdk::CreateContact.new(user.send_in_blue_attributes))
  end

  def update
    # if user doesnt have sendinblue id, then create contact
    return create unless user.contact_send_in_blue_id

    api_instance.update_contact(id, SibApiV3Sdk::UpdateContact.new(user.send_in_blue_attributes))
  end

  def delete
    api_instance.delete_contact(user.contact_send_in_blue_id)
  end
end
