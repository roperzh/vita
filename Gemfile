source 'https://rubygems.org'

ruby '2.1.1'

gem 'puma',            '~> 2.8.1'

gem 'i18n'
gem 'dotenv',          '~> 0.10.0'
gem 'sinatra',         require: 'sinatra/base'
gem 'sinatra-contrib', '~> 1.4.2'
gem 'sinatra-partial', '~> 0.4.0'

gem 'ohm',             '~> 1.3.2'
gem 'ohm-contrib',     '~> 1.2'
gem 'sprockets',       '~> 2.11.0'
gem 'linkedin',        '~> 0.4.6'

group :development do
  gem 'shotgun',       '~> 0.9'
end

group :test do
  gem 'rack-test',     require: 'rack/test'
  gem 'minitest',      require: 'minitest/autorun'
  gem 'minitest-ansi', '~> 0.1.2'
  gem 'mocha',         '~> 1.0.0'
  gem 'capybara',      '~> 2.2.1'
  gem 'simplecov',     '~> 0.8.2'
end

group :development, :test do
  gem 'rake'
end
