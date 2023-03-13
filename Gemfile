source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "bootsnap", require: false
gem "importmap-rails"
gem "jbuilder"
gem "pg"
gem "puma"
gem "rails"
gem "redis"
gem "ruby-openai"
gem "slack-ruby-client"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem "web-console"
  gem 'guard'
  gem 'guard-rspec'
end

