source 'http://rubygems.org'

gem 'rails', '>=3.0.1'

# provides authentication and user management support
gem 'devise'

# enables role-based permissions and authorization checks
gem 'cancan', '>=1.4'

# introduces a set of stylesheets with a lot of aesthetic defaults
gem 'flutie'

# HAML / SASS support
gem 'haml', '>=3.0.0'
gem 'haml-rails'

# necessary for Markdown support
gem 'rdiscount', :git => 'git://github.com/rtomayko/rdiscount.git'

# database providers (MySQL for production, Sqlite3 for development / testing)
gem 'mysql2'
gem 'sqlite3-ruby', :require => 'sqlite3'

# introduces foreign key support in Active Record for compatible database back-ends (e.g. MySQL)
gem 'foreigner', :git => 'git://github.com/matthuhiggins/foreigner.git'

group :development, :test do
    # needed for generating Devise views
    gem 'hpricot'
    gem 'ruby_parser'
end

group :test do
    gem 'cucumber-rails'
    gem 'capybara'
    gem 'factory_girl_rails', :git => 'git://github.com/thoughtbot/factory_girl_rails.git'
    gem 'rspec-rails', '>=2.0.1'
end
