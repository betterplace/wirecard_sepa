require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: :spec

desc 'Open an irb session preloaded with this library'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'wirecard_giropay'
  ARGV.clear
  IRB.start
end
