require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
end

desc 'Start a console'
task :console do
  ENV['RACK_ENV'] ||= 'development'
  %w(irb irb/completion).each { |r| require r }
  require_relative 'config/application'

  ARGV.clear
  IRB.start
end

desc 'Clean the database'
task :cleanup do
  ENV['RACK_ENV'] ||= 'development'
  require 'ohm'
  Ohm.flush
end


desc 'Run tests'
task default: :test
