source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use mongoid for MongoDB driver
gem "mongoid", "~> 8.0"

# Use pagy for pagination
gem "pagy", "~> 5.10"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# Use Apipie for documentation
gem "apipie-rails"

# Use colorize for better readable print
gem "colorize"

# Use rack-attack for blocking & throttling
gem "rack-attack"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "brakeman", "~> 6.0"
  gem "bundler-audit", "~> 0.9.1"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot", "~> 6.2.0"
  gem "rspec-rails", "~> 6.0.0"
  gem "rubocop", "~> 1.56"
  gem "rubocop-factory_bot", "~> 2.24"
  gem "rubocop-rails", "~> 2.21"
  gem "rubocop-rspec", "~> 2.24"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
