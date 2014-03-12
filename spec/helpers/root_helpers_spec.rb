require 'minitest_helper'

describe Vita::Application::RootHelpers do
  include Rack::Test::Methods

  def app
    Vita::Application
  end
end
