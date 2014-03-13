ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join('config', 'application'))
require "minitest/reporters"

Minitest::Reporters.use!
