ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require_relative './support/helpers/common_steps_helper'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  include CommonStepsHelper
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Warden::Test::Helpers
  config.include Devise::TestHelpers, type: :controller
  
  config.before :suite do
    Warden.test_mode!
  end

  def sign_in(user, opts = {})
    login_as(user, opts)
  end

  def sign_out(*scopes)
    logout(*scopes)
  end

  config.use_transactional_fixtures = true
    if defined?(ActiveRecord::Base)
    begin
      require 'database_cleaner'
      config.before(:suite) do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.clean_with(:truncation)
      end

      config.before(:each) do
        DatabaseCleaner.start
      end

      config.after(:each) do
        DatabaseCleaner.clean
      end

    rescue LoadError => ignore_if_database_cleaner_not_present
    end
  end

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
end
