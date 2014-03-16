require 'minitest_helper'
require 'linkedin'

describe ProfilePresenter do
  include Rack::Test::Methods

  let(:presenter)    { ProfilePresenter.new }

  describe 'instance methods' do

    before do
      LinkedIn::Client.any_instance.stubs(:profile).returns(fake_response)
    end

    it '#get' do
      presenter.get(:first_name).must_equal 'John'
      presenter.get(:last_name).must_equal 'Doe'
    end

    it '#full_name' do
      presenter.full_name.must_equal 'John Doe'
    end
  end

end
