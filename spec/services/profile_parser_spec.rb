require "minitest_helper"
require "linkedin"

describe ProfileParser do
  include Rack::Test::Methods

  let(:parser)    { ProfileParser.new(Profile.new) }
  let(:profile)   { Profile[1] }

  describe "#parse" do

    before do
      Ohm.redis.flushdb
      LinkedIn::Client.any_instance.stubs(:profile).returns(fake_response)
      parser.parse
    end

    context "given a new profile" do
      it "fills the database with fresh data and saves it" do
        profile.get(:full_name).must_equal "John Doe"

        profile.get(:avatar).must_equal("http://example.com")

        profile.get(:skills).must_equal("[{\"name\":\"skill_1\"}]")

        profile.get(:educations).must_equal(
          "[{\"school_name\":\"Some school around here\",\"summary\":null,\"degree\":null,\"notes\":null,\"start_date\":\"2323-09-01\",\"end_date\":\"2323-09-01\"}]"
        )

        profile.get(:positions).must_equal(
          "[{\"company\":\"Hash Brothers\",\"title\":\"Ingenieer\",\"summary\":null,\"start_date\":\"2323-09-01\",\"end_date\":\"2323-09-01\"}]"
        )

        profile.get(:projects).must_equal(
          "[{\"description\":\"cool project description\",\"name\":\"cool project name\",\"url\":\"cool url\"}]"
        )

        profile.get(:courses).must_equal(
          "[{\"id\":\"343\",\"name\":\"cool course name\"}]"
        )
      end
    end
  end

end
