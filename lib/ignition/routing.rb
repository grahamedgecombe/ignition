require 'action_dispatch'

module Ignition
  # The subdirectory of the app/views directory where static pages are loaded
  # from. This is set to <tt>'pages'</tt>.
  PAGES_DIRECTORY = 'pages'.freeze

  # A constraint which checks if the specified page exists.
  class PageExistsConstraint
    class << self
      # Checks if the page specified by the <tt>id</tt> path parameter exists.
      def matches?(request)
        id = request.symbolized_path_parameters[:id]
        return exists_and_valid? id
      end

      private
        # Checks that the page with the specified <tt>id</tt> exists and does not
        # map to a template outside of the <tt>RAILS_ROOT/app/views/pages</tt>
        # directory.
        def exists_and_valid?(id)
          found = false
          Rails.application.config.paths['app/views'].each do |path|
            base = File.expand_path(Ignition::PAGES_DIRECTORY, path)
            file = File.expand_path(id, base)
            if not file.starts_with? base
              return false
            end
            found = true unless Dir.glob("#{file}.*").empty?
          end
          return found
        end
    end
  end

  # Extends the default <tt>ActionDispatch::Routing::Mapper</tt> module with a
  # <tt>static</tt> method which creates a route for static content.
  module Mapper
    # Adds a new route which matches all URLs after the specified prefix and
    # forwards requests to Ignition's static pages controller. If no prefix is
    # specified the default is <tt>'/'</tt>.
    # A hash of options can also be passed. The <tt>:as</tt> option specifies
    # a different name for the route (the default is <tt>'page'</tt>).
    def static(prefix = '/', options = {})
      prefix = prefix.gsub /\/$/, ''
      constraints Ignition::PageExistsConstraint do
        get "#{prefix}/*id", :to => 'ignition/pages#show', :as => (options[:as] || 'page')
      end
    end
  end
end

ActionDispatch::Routing::Mapper.send :include, Ignition::Mapper
