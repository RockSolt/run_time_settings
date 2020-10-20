require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
  require 'irb'
  require 'irb/completion'
  require 'run_time_settings'
  require_relative 'spec/database'

  # enable interaction with test model Test::Configuration at console
  require_relative 'spec/support/configuration'

  ARGV.clear
  IRB.start
end
