# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.2'

# DRY-RB
gem 'dry-auto_inject', '= 0.7.0'
gem 'dry-monads', '~> 1.3'
gem 'dry-system', '= 0.18.1'
gem 'dry-validation', '~> 1.5'

# Database
gem 'pg', '~> 1.2'
gem 'rom', '~> 5.2'
gem 'rom-sql', '~> 3.2'

# System
gem 'dotenv', '~> 2.7'
gem 'rake', '~> 13.0'

# Web
gem 'hanami-controller', '~> 1.3'
gem 'hanami-router', '~> 1.3'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1'

group :development do
  gem 'rubocop', '~> 1.3', require: false
  gem 'rubocop-performance', '~> 1.8', require: false
  gem 'rubocop-rake', '= 0.5.1', require: false
  gem 'rubocop-rspec', '~> 2.0', require: false

  gem 'pry', '= 0.13.1'
  gem 'pry-byebug', '~> 3.9'
end

group :test do
  gem 'rack-test', '~> 1.1'
  gem 'rspec', '~> 3.10'
end
