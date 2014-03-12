module Vita::Application
  class RootController < ApplicationController
    set prefix: '/'
    set views_prefix: '/root'

    helpers Vita::Application::RootHelpers

    get '/' do
      erb :index
    end
  end
end
