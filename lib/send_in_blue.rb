# frozen_string_literal: true

require_relative "send_in_blue/version"

require 'sib-api-v3-sdk'
require 'activesupport'
require 'sidekiq'

module SendInBlue
  class Error < StandardError; end
  # Your code goes here...
end
