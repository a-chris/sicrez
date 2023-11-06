# frozen_string_literal: true

require_relative "lib/sicrez/version"

Gem::Specification.new do |spec|
  spec.name = "sicrez"
  spec.version = Sicrez::VERSION
  spec.authors = ["a-chris"]
  spec.email = ["a.christian.toscano@gmail.com"]

  spec.summary = "Sicrez is the single point of access for your Rails Credentials, Secrets, ENV, <whatever>"
  spec.description = "Sicrez is the single point of access for your Rails Credentials, Secrets, ENV, <whatever>"
  spec.homepage = "https://github.com/a-chris/sicrez"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/a-chris/sicrez"
  spec.metadata["changelog_uri"] = "https://github.com/a-chris/sicrez"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "hashie"
end
