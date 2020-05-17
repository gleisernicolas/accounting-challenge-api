# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'rubocop-performance'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
  gem 'pry'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
