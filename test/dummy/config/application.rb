require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require File.expand_path('../../../../lib/ignition', __FILE__)

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Dummy
  class Application < Rails::Application
    config.encoding = "utf-8"

    # Don't eagerly load classes at startup
    config.eager_load = false

    # Raise exceptions instead of rendering exception templates
    config.action_dispatch.show_exceptions = false
  end
end
