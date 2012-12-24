require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups(:assets => %w(development test)))

module RecipeBox
  class Application < Rails::Application
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end
