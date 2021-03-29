require 'rails/generators'

module SendInBlue
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      desc "Setup Send In Blue integration. Argument is the name of your Send In Blue Contact model, e.g. User"
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

      def add_send_in_blue_id_to_contact_model
        generate "migration", "AddSendInBlueIdTo#{plural_name}", "send_in_blue_id:string:uniq"
      end
    end
  end
end
