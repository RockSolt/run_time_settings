# frozen_string_literal: true

require_relative 'lib/run_time_settings/version'

Gem::Specification.new do |spec|
  spec.name          = 'run_time_settings'
  spec.version       = RunTimeSettings::VERSION
  spec.authors       = ['Todd Kummer']
  spec.email         = ['todd@rockridgesolutions.com']

  spec.summary       = 'Persistent, run-time application settings'
  spec.description   = 'Easily add and manage application-level settings'
  spec.homepage      = 'https://github.com/RockSolt/run_time_settings'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_development_dependency 'guard', '~> 2.16'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.3'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.90.0'
  spec.add_development_dependency 'simplecov', '~> 0.19'
end
