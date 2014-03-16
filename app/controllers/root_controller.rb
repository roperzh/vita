module Vita::Application
  require "linkedin"

  class RootController < ApplicationController
    set prefix: '/'
    set views_prefix: '/root'

    get '/' do
      erb :index
    end

  private
    def profile
      ProfileParser.new(Profile.new).parse unless Profile[1]

      @profile ||= Profile[1]
    end
  end
end
