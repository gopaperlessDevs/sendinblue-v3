require_relative "lib/send_in_blue/version"

Gem::Specification.new do |spec|
  spec.name          = "send_in_blue"
  spec.version       = SendInBlue::VERSION
  spec.authors       = ["Ethaning"]
  spec.email         = ["ethan.carter@gopaperless.eu"]

  spec.summary       = "Integration for sendinblue APIs "
  # spec.description   = "TODO: Write a longer description or delete this line."
  spec.homepage      = "https://github.com/gopaperlessDevs/send_in_blue"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gopaperlessDevs/send_in_blue"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency "activesupport", ">= 5"
  spec.add_runtime_dependency "addressable"
  spec.add_runtime_dependency "sib-api-v3-sdk"
  spec.add_runtime_dependency "sidekiq", ">= 2"

  spec.add_development_dependency "pry"
  # spec.add_development_dependency "rails", "~> 5.0.0"
  spec.add_development_dependency "rails", ">= 5"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rails"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
