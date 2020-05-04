# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "canary/version"

Gem::Specification.new do |spec|
  spec.name          = "canary"
  spec.version       = Canary::VERSION
  spec.authors       = ["ebrohman"]
  spec.email         = ["ericbrohman@gmail.com"]

  spec.summary       = "Canary"
  spec.description   = "CLI app for telemetry data"
  spec.homepage      = "https://github.com/ebrohman/canary"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ebrohman/canary"
  spec.metadata["changelog_uri"] = "https://github.com/ebrohman/canary"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "faraday"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "thor"
end
