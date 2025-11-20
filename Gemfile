source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0", ">= 8.0.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "light-service"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "factory_bot", "~> 6.5"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
  gem "rspec-rails", "~> 6.0.3"
  gem "shoulda-matchers"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  gem "rubocop"
  gem "annotate"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "light-service"
gem "tailwindcss-rails", "~> 2.3"
gem "prettytodo", "~> 0.1.0"
