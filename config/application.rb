require 'bundler'
require 'forwardable'
require 'dotenv'
require 'ohm'
require 'sinatra/partial'

module Vita
  module Application
    rack_env = ENV.fetch('RACK_ENV', 'development').to_sym

    Bundler.require(:default, rack_env)

    # initialize dotenv
    Dotenv.load(".env.#{rack_env}", '.env')

    # connect to the redis database
    Ohm.connect

    # require the application controller
    require File.expand_path(
      File.join('app', 'controllers', 'application_controller')
    )

    extend SingleForwardable
    def_single_delegators ApplicationController, :call, :configure, :new, :settings

    require File.expand_path(File.join('config', 'environment'))

    paths = %w(
      config/environments config/initializers app/services app/controllers
      app/models
    )

    paths.each do |path|
      files = File.join(path, '**/*.rb')
      Dir[files].each { |file| require File.expand_path(file) }
    end
  end
end
