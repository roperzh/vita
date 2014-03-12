require 'minitest_helper'

describe Vita::Application::ApplicationController do
  include Rack::Test::Methods

  def app
    Vita::Application
  end
end
