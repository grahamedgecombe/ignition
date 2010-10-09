require 'action_dispatch'

module Ignition
  # Extends the default <tt>ActionDispatch::Routing::Mapper</tt> module with a
  # <tt>static</tt> method which creates a route for static content.
  module Mapper
    # Adds a new route which matches all URLs after the specified prefix and
    # forwards requests to Ignition's static pages controller. If no prefix is
    # specified the default is '/'.
    def static(prefix = '/')
      prefix = prefix.gsub /\/$/, ''
      get "#{prefix}/*id", :to => 'ignition/pages#show', :as => 'page'
    end
  end
end

ActionDispatch::Routing::Mapper.send :include, Ignition::Mapper
