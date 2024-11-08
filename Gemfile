source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Gem lecture de pdf
gem "poppler"

# Gem pour les images
gem "mini_magick"

# Devise for authentication
gem "devise" # 4.9.3

# Pundit for authorisation et politique de droits d'accès
gem "pundit" # 2.3.1

# Manage front Bootstrap CSS & JS
gem "bootstrap", "~> 5.3.2"
gem 'bootstrap-icons-helper'
gem 'popper_js'

gem "autoprefixer-rails"
gem "font-awesome-sass", "~> 6.1"
gem "simple_form", github: "heartcombo/simple_form"
gem "sassc-rails"

gem 'mobility', '~> 1.3.0.rc3'

group :development, :test do
  gem "dotenv-rails"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]

  # Helper pour avoir les informations des modèles dans les fichiers
  gem 'annotate', '~> 3.2'

  # Email envoyé ouvert dans navigateur
  gem "letter_opener"

  # Pry pour débuggage
  gem "pry-byebug"
  gem "pry-rails"
  gem "byebug"

  # Tests + Factory Bot pour les tests
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "database_cleaner"

end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver" # 4.19
  gem "webdrivers" # 5.2

  # Enregistre screenshots lors des tests et erreurs
  gem "launchy"

  # Helper pour les tests Models et Pundit
  gem "shoulda-matchers"
  gem "pundit-matchers"
end

gem "aws-sdk-s3", require: false
