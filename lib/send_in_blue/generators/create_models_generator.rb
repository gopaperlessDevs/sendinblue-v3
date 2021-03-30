require "rails/generators"

module SendInBlue
  module Generators
    class CreateModelsGenerator < Rails::Generators::Base
      desc "Create model to integrate Send In Blue email templates into the app."
      # class_option :orm, required: true

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), "templates")
      end

      def create_email_templates_model
        generate "model", "SendInBlueEmailTemplate", "sib_template_id:integer event:integer"
      end
    end
  end
end
