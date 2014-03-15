ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join('config', 'application'))

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/spec/"
    add_filter "/vendor/bundle"
  end
end

require "dotenv"
Dotenv.load ".env.test", ".env"

require "minitest/autorun"
require "rack/test"
require 'mocha/mini_test'

require "minitest/ansi"
MiniTest::ANSI.use!

# Helper methods
def fake_response
  LinkedIn::Mash.new({
    first_name: "John",
    last_name: "Doe"
  })
end
