require 'ignition/config'
require 'rails'

module Ignition
  class Engine < Rails::Engine
    config.ignition = Ignition::Configuration.new
  end
end

# this hack allows URLs to be generated correctly if the engine is mounted at /
class ActionDispatch::Routing::Mapper
  private
    alias_method :old_define_generate_prefix, :define_generate_prefix

    def define_generate_prefix(app, name)
      ret = old_define_generate_prefix(app, name)
      app.routes.singleton_class.class_eval do
        alias_method :_old_generate_prefix, :_generate_prefix

        redefine_method :_generate_prefix do |options|
          prefix = _old_generate_prefix(options)
          return prefix == '/' ? '' : prefix
        end
      end
    end
end
