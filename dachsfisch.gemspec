# frozen_string_literal: true

require_relative 'lib/dachsfisch/version'

Gem::Specification.new do |spec|
  spec.name = 'dachsfisch'
  spec.version = Dachsfisch::VERSION
  spec.authors = ['Karol']
  spec.email = ['git@koehn.pro']

  spec.summary = 'Badgerfish implementation'
  spec.description = 'Implements a bidirectional converter for XML and JSON based on the badgerfish-specification'
  spec.homepage = 'https://github.com/openHPI/dachsfisch'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-github', '~> 2.4.0'
  spec.add_development_dependency 'rubocop', '~> 1.50.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.17.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.19.0'
  spec.add_development_dependency 'simplecov', '~> 0.22.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
