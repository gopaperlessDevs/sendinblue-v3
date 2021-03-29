# frozen_string_literal: true

require_relative "send_in_blue/version"

# dependencies
require 'sib-api-v3-sdk'
require 'active_support/concern'
require 'sidekiq'

# app code
require 'send_in_blue/contact'
require 'send_in_blue/workers/contact_worker'
require 'send_in_blue/workers/event_email_worker'

# generators
require 'send_in_blue/generators'
require 'send_in_blue/generators/install_generator'
require 'send_in_blue/generators/create_models_generator'
require 'send_in_blue/generators/templates/initializer'


module SendInBlue
  class Error < StandardError; end
  # Your code goes here...
end
