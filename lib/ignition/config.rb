module Ignition
  class Configuration
    attr_accessor :cache, :view_prefix, :layout

    def initialize
      @cache = :none
      @view_prefix = 'pages'
      @layout = 'application'
    end
  end
end
