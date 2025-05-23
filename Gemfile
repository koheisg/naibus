# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'geared_pagination'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'redis'
gem 'ruby-openai'
gem 'slack-ruby-client'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'web-console'
end

gem 'sidekiq', '~> 7.0'

gem 'ferrum', '~> 0.13'
