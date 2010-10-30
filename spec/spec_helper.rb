require 'spork'

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'
  require File.dirname(__FILE__) + '/../config/environment' unless defined?(Rails)
  require 'rspec/core'
  require 'rspec/rails'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| load f }

  RSpec.configure do |config|
    config.include Devise::TestHelpers, :type => :controller

    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true

    # We want these helpers for most of the view specss
    config.before :all, :type => :view do
      self.class.helper :application
    end

    # Reload the routes before each spec file is run
    config.before :all, :type => :routing do
      Rails.application.reload_routes!
    end

    # Reload our factories in case we changed them
    config.before :suite do
      Factory.factories.clear
      Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each { |f| load f }
    end
  end
end

Spork.each_run do
  # Stuff here gets executed each run. Put in a before :suite if possible
end
