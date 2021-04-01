# SendInBlue

## Installation

You may need to create an access token on Github to be able to install this private repo. Follow instructions here: https://medium.com/@frodsan/installing-a-gem-from-a-private-github-repo-heroku-a895073ae7d

In short:
`bundle config --local GITHUB__COM myoauthtoken:x-oauth-basic`

and on heroku:
`heroku config:add BUNDLE_GITHUB__COM=myoauthtoken:x-oauth-basic`

Add this line to your application's Gemfile:

```ruby
gem "send_in_blue", git: 'https://github.com/gopaperlessDevs/send_in_blue.git'
```

And then execute:

    $ bundle install


run the initializer with:

```ruby
rails g send_in_blue:install
```

or add an initializer with the following code:

```ruby
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
```

## Usage

Include ```SendInBlue::Contact``` in the model which should correspond to Send In Blue contacts.

If the SendInBlue gem is not in test mode, then SendInBlue API will be called every time the an instance of the contact_model is created, updated or deleted.

Configure a custom id field for use with SendInBlue APIs wth ```send_in_blue_id```.
Configure a the email field to use with SendInBlue APIs wth ```send_in_blue_email_field``` (defaults to :email).
Configure a custom contact attributes for use with SendInBlue APIs wth ```send_in_blue_attributes```.


```ruby
# class User
class Account
  # ...
  include SendInBlue::Contact

  send_in_blue_id :send_in_blue_id
  send_in_blue_email_field :contact_email # defaults to :email
  send_in_blue_consent_field :gdpr_opt_in_field
  send_in_blue_attributes :subscribe_gdpr_news, :full_name, :email, :is_subscribed #, ...

  # ...
end
```

To upload new local contact attributes to SendInBlue, run:
```bash
rails send_in_blue:sync_contact_attributes_to_remote
```

You will have to manually enter the type for each new attribute. Valid attribute types are: (T)ext, (D)ate, (N)umber, (B)oolean.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/send_in_blue.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
