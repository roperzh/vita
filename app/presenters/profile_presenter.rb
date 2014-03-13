class ProfilePresenter
  attr_reader :client, :profile

  def initialize
    @client  = LinkedIn::Client.new(ENV['CONSUMER_KEY'],ENV['CONSUMER_SECRET'])
    @client.authorize_from_access(ENV['CLIENT_TOKEN'], ENV['CLIENT_ACCESS'])
    @profile = client.profile
  end

  def full_name
    profile.first_name + profile.last_name
  end
end
