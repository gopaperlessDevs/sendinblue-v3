require 'rails/generators'

module SendInBlue
  module Generators
    MissingORMError = Class.new(Thor::Error)

    class InstallGenerator < Rails::Generators::Base
      desc "Setup Send In Blue integration"
      # class_option :orm, required: true

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def copy_initializer_file
        # unless options[:orm]
        #   raise MissingORMError, <<-ERROR.strip_heredoc
        #   An ORM must be set to install Devise in your application.
        #   Be sure to have an ORM like Active Record or Mongoid loaded in your
        #   app or configure your own at `config/application.rb`.
        #     config.generators do |g|
        #       g.orm :your_orm_gem
        #     end
        #   ERROR
        # end

        copy_file "initializer.rb", "config/initializers/send_in_blue.rb"
      end

      def create_email_templates_model
        generate "model", "SendInBlueEmailTemplate", "sib_template_id:integer event:integer"
      end
    end
  end
end
