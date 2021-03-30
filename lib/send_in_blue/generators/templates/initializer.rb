# setup authorization
SibApiV3Sdk.configure do |config|
  # Configure API key authorization: api-key
  config.api_key["api-key"] = "SEND_IN_BLUE_API_KEY"

  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['api-key'] = 'Bearer'

  # Configure API key authorization: partner-key
  config.api_key["partner-key"] = "SEND_IN_BLUE_PARTNER_API_KEY"

  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['partner-key'] = 'Bearer'
end

SendInBlue.configure do |c|
  # insert your own contact model here
  c.contact_model = User
end
