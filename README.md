# SendInBlue

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sendinblue-v3'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sendinblue-v3


add an initializer with the following code:

```ruby
SibApiV3Sdk.configure do |config|
  # Configure API key authorization: api-key
  config.api_key['api-key'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['api-key'] = 'Bearer'

  # Configure API key authorization: partner-key
  config.api_key['partner-key'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['partner-key'] = 'Bearer'
end
```
## Usage

Include ```SendInBlue::Contact``` in the model which should correspond to Send In Blue contacts.

Configure a custom id field for use with SendInBlue APIs wth ```send_in_blue_id```.
Configure a custom contact attributes for use with SendInBlue APIs wth ```send_in_blue_attributes```.


```ruby
# class User
class Account
  # ...
  include SendInBlue::Contact

  send_in_blue_id :custom_id_field
  send_in_blue_attributes :subscribe_gdpr_news, :full_name, :email, :has_been_reseller,
                          :is_subscribed, ...

  # ...
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sendinblue-v3.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
