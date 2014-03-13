module Vita::Application
  require "linkedin"

  class RootController < ApplicationController
    set prefix: '/'
    set views_prefix: '/root'

    helpers Vita::Application::RootHelpers

    get '/' do
      erb :index
    end

  private
    def profile
      return @profile unless @profile.nil?

      client = LinkedIn::Client.new(ENV['CONSUMER_KEY'],ENV['CONSUMER_SECRET'])
      client.authorize_from_access(ENV['CLIENT_TOKEN'], ENV['CLIENT_ACCESS'])
      @profile = client.profile
    end
  end
end
