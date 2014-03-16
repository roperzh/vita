require "minitest_helper"

describe Vita::Application::RootController do
  include Rack::Test::Methods

  def app
    Vita::Application
  end

  describe "GET /" do

    before do
      LinkedIn::Client.any_instance.stubs(:profile).returns(fake_response)
      get "/"
    end

    let(:profile) { ProfileParser.new(Profile.new).parse }

    it "must be ok" do
      last_response.must_be :ok?
    end

    context "given the body content" do
      it "shows the user's basic information" do
        last_response.body.must_match profile.full_name
        last_response.body.must_match profile.headline
      end

      it "shows the user's positions" do
        last_response.body.must_match profile.positions.first[:title]
        last_response.body.must_match profile.positions.first[:company]
      end

      it "shows the user's educations" do
        last_response.body.must_match profile.educations.first[:school_name]
      end

      it "shows the user's projects" do
        last_response.body.must_match profile.projects.first[:name]
        last_response.body.must_match profile.projects.first[:description]
      end

      it "shows the user's skills" do
        last_response.body.must_match profile.skills.first[:name]
      end

      it "shows the user's courses" do
        last_response.body.must_match profile.courses.first[:name]
      end
    end
  end
end
