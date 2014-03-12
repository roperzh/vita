require 'minitest_helper'

describe Vita::Application::RootController do
  include Rack::Test::Methods

  def app
    Vita::Application
  end

  describe 'GET /' do
    it 'must be ok' do
      get '/'
      last_response.must_be :ok?
      last_response.body.must_match 'Hello World'
    end
  end
end
