module SendInBlue
  class Railtie < Rails::Railtie
    rake_tasks do
      Dir["lib/send_in_blue/tasks/**/*.rake"].each { |f| load f }
    end
  end
end
