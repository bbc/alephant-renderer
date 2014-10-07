$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rspec/core/rake_task'
require 'bundler/gem_tasks'
require 'alephant/renderer'

RSpec::Core::RakeTask.new(:spec) do |t|
  task.exclude_pattern = 'spec/integration/**/*_spec.rb'
  task.rspec_opts = ['--color', '--format', 'doc', '--format=Nc']
end

RSpec::Core::RakeTask.new(:integration) do |task|
  task.pattern = 'spec/integration/**/*_spec.rb'
  task.rspec_opts = ['--color', '--format', 'doc', '--format=Nc']
end

RSpec::Core::RakeTask.new(:all) do |task|
  task.rspec_opts = ['--color', '--format', 'doc', '--format=Nc']
end

task :default => :spec
