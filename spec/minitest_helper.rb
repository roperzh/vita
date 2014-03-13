ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join('config', 'application'))

require "minitest/reporters"
Minitest::Reporters.use!

require 'minitest/unit'
require 'mocha/mini_test'

# Helper methods

def fake_response
  LinkedIn::Mash.new({
    first_name: "John",
    last_name: "Doe"
  })
end
