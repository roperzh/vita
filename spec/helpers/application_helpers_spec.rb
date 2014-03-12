require 'minitest_helper'

describe Vita::Application::ApplicationHelpers do
  include Rack::Test::Methods

  def app
    Vita::Application
  end
end
