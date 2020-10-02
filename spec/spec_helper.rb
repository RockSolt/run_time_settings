# frozen_string_literal: true

require 'bundler/setup'

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'run_time_settings'
require 'database'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.filter_run_when_matching :focus
  config.default_formatter = 'doc' if config.files_to_run.one?

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after(:example) { RunTimeSettings::Settings.delete_all }
end
