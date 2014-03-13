require 'minitest_helper'
require 'linkedin'

describe ProfilePresenter do
  include Rack::Test::Methods

  let(:presenter)    { ProfilePresenter.new }

  describe 'instance methods' do
    it '#get' do
      LinkedIn::Client.any_instance.stubs(:profile).returns(fake_response)

      presenter.get(:first_name).must_equal('John')
      presenter.get(:last_name).must_equal('Doe')
    end
  end

end
