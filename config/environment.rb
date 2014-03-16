Vita::Application.configure do |config|
  # directory structure
  config.set :root, File.expand_path('../..', __FILE__)
  config.set :views, File.join(config.root, 'app', 'views')

  # i18n
  I18n.load_path = Dir[File.join('config', 'locales', '*.{rb,yml}').to_s]
  I18n.default_locale = 'en'

  # link header
  config.helpers Sinatra::LinkHeader

  # logging
  unless Sinatra::Base.production?
    file = File.new("#{config.root}/log/#{config.environment}.log", 'a+')
    file.sync = true
    config.use Rack::CommonLogger, file
  end

  # method override
  config.enable :method_override

  # partial
  config.register Sinatra::Partial
  config.set :partial_template_engine, :erb
  config.enable :partial_underscores

  # sessions
  config.enable :sessions

  # show exceptions
  config.enable :show_exceptions

  # sprockets
  config.builder.map '/assets' do
    environment = Sprockets::Environment.new
    environment.append_path File.join(config.root, 'app', 'assets', 'javascripts')
    environment.append_path File.join(config.root, 'app', 'assets', 'stylesheets')
    run environment
  end

  # template engine
  config.set :erb, layout_engine: :erb, layout: '../layouts/application'.to_sym
end
