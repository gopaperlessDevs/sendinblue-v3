require 'rails'
require 'active_record'

class User < ActiveRecord::Base
  include SendInBlue::Contact
end
