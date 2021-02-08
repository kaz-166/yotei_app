source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.1'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Postgersql as a database engine
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'duktape'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Use JQuery in rails
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Use DateTimePicker(for bootstrap4)
gem 'momentjs-rails'
gem 'bootstrap4-datetime-picker-rails'
# Internationalization and localization
gem 'rails-i18n'
# Use Devise for authentication
gem 'devise'
# Use twitter API
gem 'omniauth-twitter'
gem 'twitter'
# Use bootstrap
gem 'bootstrap-sass', '3.3.7'
# Use Google map API
gem 'gmaps4rails'
# Use GON to exchange data between rails and javasctipt
gem 'gon'
# Use modal window
gem 'data-confirm-modal'
gem 'dotenv-rails'
# Use Nokogiri for web scraping
gem 'nokogiri'
# Use rails-erd to generate ER-Diagram
gem 'rails-erd'
# Use CarrierWave as an image uploader
gem 'carrierwave', '~> 1.3'
# Use SimpleCalendar to show event calendar
gem 'simple_calendar'
# Use rails-admin 
gem 'rails_admin', '~> 2.0'
gem 'cancancan'
gem 'config'
# Use KAMINARI for pagination
gem 'kaminari'
# Use Rubocop as a static code analizer
gem 'rubocop'
gem 'rubocop-rails'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'webdrivers'
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'brakeman'
end

group :test do
end

group :production do
  gem 'fog-aws'
end

