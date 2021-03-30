# frozen_string_literal: true

require_relative "send_in_blue/version"

# dependencies
require "sib-api-v3-sdk"
require "active_support/concern"
require "sidekiq"

# app code
require "send_in_blue/config"
require "send_in_blue/contact"
require "send_in_blue/workers/contact_worker"
require "send_in_blue/workers/event_email_worker"

# generators
require "send_in_blue/generators"
require "send_in_blue/generators/install_generator"
require "send_in_blue/generators/create_models_generator"
# require 'send_in_blue/generators/templates/initializer'

module SendInBlue
  class Error < StandardError; end

  class << self
    # Instantiate the Configuration singleton
    # or return it. Remember that the instance
    # has attribute readers so that we can access
    # the configured values
    def config
      @config ||= Config.new
    end

    # This is the configure block definition.
    # The configuration method will return the
    # Configuration singleton, which is then yielded
    # to the configure block. Then it's just a matter
    # of using the attribute accessors we previously defined
    def configure
      yield(config)
    end
  end
end
