require 'ignition'

# A Rails controller which maps static content to actual template files in the
# <tt>RAILS_ROOT/app/views/pages</tt> directory.
class Ignition::PagesController < ApplicationController
  # The cascade header used by the router.
  X_CASCADE = 'X-Cascade'.freeze

  # The value in the cascade header which causes the router to pass and try the
  # next route.
  PASS = 'pass'.freeze

  # The subdirectory of the app/views directory where static pages are loaded
  # from. This is set to <tt>'pages'</tt>.
  PAGES_DIRECTORY = 'pages'.freeze

  # Creates the controller, setting the cache method chosen using the
  # <tt>Ignition::Configuration</tt> class.
  def initialize
    super

    caching_method = Ignition::Configuration.caching_method
    if caching_method == :page
      caches_page :show
    elsif caching_method == :page_without_layout
      caches_action :show, :layout => false
    elsif caching_method == :none
      # do nothing
    else
      raise "Invalid caching method: #{caching_method}"
    end
  end

  # Attempts to show the page specified by the <tt>params[:id]</tt> parameter.
  def show
    id = params[:id]

    if not valid_path? id
      render_404
    else
      begin
        render :template => "#{PAGES_DIRECTORY}/#{id}"
      rescue ActionView::MissingTemplate
        render_404
      end
    end
  end

  private
    # Checks that the page with the specified <tt>id</tt> is valid and does not
    # map to a template outside of the <tt>RAILS_ROOT/app/views/pages</tt>
    # directory. If it does, an exception is thrown.
    def valid_path?(id)
      Rails.application.paths.app.views.each do |path|
        base = File.expand_path(PAGES_DIRECTORY, path)
        file = File.expand_path(id, base)
        if not file.starts_with? base
          return false
        end
      end
      return true
    end

    # Renders a 404 response with the X-Cascade header set to 'pass'. This
    # causes the router to carry on trying rules.
    def render_404
      headers[X_CASCADE] = PASS
      render :nothing => true, :status => :not_found
    end
end
