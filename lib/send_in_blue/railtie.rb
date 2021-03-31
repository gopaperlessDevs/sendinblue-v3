module SendInBlue
  class Railtie < Rails::Railtie
    rake_tasks do
      Dir["lib/send_in_blue/tasks/**/*.rake"].each { |f| load f }

      spec = Gem::Specification.find_by_name 'send_in_blue'
      load "#{spec.gem_dir}/lib/send_in_blue/tasks/send_in_blue.rake"
    end
  end
end
