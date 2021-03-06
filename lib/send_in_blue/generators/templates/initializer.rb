# setup authorization
SibApiV3Sdk.configure do |config|
  # Configure API key authorization: api-key
  config.api_key["api-key"] = ENV["SEND_IN_BLUE_API_KEY"]

  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['api-key'] = 'Bearer'

  # Configure API key authorization: partner-key
  config.api_key["partner-key"] = ENV["SEND_IN_BLUE_PARTNER_API_KEY"]

  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['partner-key'] = 'Bearer'
end

SendInBlue.configure do |c|
  # insert your own contact model here
  c.contact_model = User
  c.env = ENV["SEND_IN_BLUE_ENV"] || Rails.env

  # if test mode is a truthy value, then active record callbacks on the contact model will not be called
  c.test_mode = ENV["SEND_IN_BLUE_TEST_MODE"] || false
end
