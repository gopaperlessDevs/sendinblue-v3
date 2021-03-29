# require 'sidekiq'

class SendInBlue::EventEmailWorker
  include Sidekiq::Worker

  def perform(user_id, action, opts = {})
    @user = User.find(user_id)

    send :action, opts
  rescue SibApiV3Sdk::ApiError => e
    raise SendInBlue::Error.new("Error when calling SendInBlue ContactsApi.#{action} for #{user_id}: #{e}"
  end
end
