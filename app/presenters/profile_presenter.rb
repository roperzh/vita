class ProfilePresenter
  attr_reader :client, :profile

  def initialize()
    @client  = LinkedIn::Client.new(ENV['CONSUMER_KEY'],ENV['CONSUMER_SECRET'])
    client.authorize_from_access(ENV['CLIENT_TOKEN'], ENV['CLIENT_ACCESS'])

    @profile = client.profile(fields:
      %w(languages skills certifications educations courses volunteer first_name
         last_name headline location summary positions picture-url))
  end

  def get(value)
    profile.send(value)
  end
end
