module Ignition
  # Configures Ignition. A block should be passed which accepts a single
  # <tt>config</tt> parameter. Configuration options can be set using this
  # object.
  # 
  # *config.caching_method*
  # 
  # Determines the type of caching used.
  # * <tt>:none</tt>: caching is not performed (this is the default).
  # * <tt>:page</tt>: uses the default Rails page caching.
  # * <tt>:page_without_layout</tt>: uses action caching without caching the
  #   overall layout.
  def self.configure # :yields: config
    yield Ignition::Configuration
  end

  # Contains configuration for the Ignition plugin. Although it is possible to
  # set configuration directly using this object, this functionality should be
  # considered deprecated and it is preferrable to use Ignition::configure to
  # configure Ignition.
  class Configuration < BasicObject
    class << self
      # The type of caching used. The default is <tt>:none</tt>. Other valid
      # options are <tt>:page</tt> and <tt>:page_without_layout</tt>.
      # <tt>:page</tt> uses the default Rails page caching.
      # <tt>:page_without_layout</tt> uses action caching without caching the
      # overall layout.
      attr_accessor :caching_method
    end
  end
end

Ignition.configure do |config|
  config.caching_method = :none unless config.caching_method
end
