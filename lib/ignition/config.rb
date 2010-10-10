module Ignition
  # Contains configuration for the Ignition plugin.
  module Configuration
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

Ignition::Configuration.caching_method = :none
