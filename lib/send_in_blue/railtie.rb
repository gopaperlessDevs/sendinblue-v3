module SendInBlue
  class Railtie < Rails::Railtie
    rake_tasks do
      spec = Gem::Specification.find_by_name "send_in_blue"
      load "#{spec.gem_dir}/lib/send_in_blue/tasks/send_in_blue.rake"
    end
  end
end
