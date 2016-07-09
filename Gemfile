source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.rc2', '< 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'bootstrap-sass'
gem 'coffee-rails', '~> 4.1.0'
gem 'devise'
gem 'ffaker'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
# gem 'kaminari', git: "git://github.com/amatsuda/kaminari.git", branch: 'master'
gem 'sass-rails', '~> 5.0'
gem 'simple_form', github: 'kesha-antonov/simple_form', branch: 'rails-5-0'
gem 'slim-rails'
gem 'turbolinks', '~> 5.x'
gem 'uglifier', '>= 1.3.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'awesome_print'
  gem 'binding_of_caller'
  gem 'byebug', platform: :mri # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'capybara'
  gem 'dotenv-rails' # Autoloads dotenv in Rails.
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'listen', '~> 3.0.5'
  gem 'quiet_assets'
  gem 'rails-erd'
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console' # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
end

group :test do
  gem 'database_cleaner'
  gem 'json_spec', '~> 1.1', '>= 1.1.4'
  gem "poltergeist"
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
