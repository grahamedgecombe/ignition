require 'ignition/config'
require 'rails'

module Ignition
  class Engine < Rails::Engine
    config.ignition = Ignition::Configuration.new
  end
end
