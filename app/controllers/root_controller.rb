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
      @profile ||= Profile[1]
    end
  end
end
