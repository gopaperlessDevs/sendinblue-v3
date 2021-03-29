# frozen_string_literal: true

require_relative "send_in_blue/version"

require 'sib-api-v3-sdk'
require 'active_support/concern'
require 'sidekiq'

require 'send_in_blue/contact'
require 'send_in_blue/workers/contact_worker'
require 'send_in_blue/workers/event_email_worker'

module SendInBlue
  class Error < StandardError; end
  # Your code goes here...
end
