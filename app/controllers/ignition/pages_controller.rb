# A Rails controller which maps static content to actual template files in the
# <tt>RAILS_ROOT/app/views/pages</tt> directory.
class Ignition::PagesController < ApplicationController
  # Attempts to show the page specified by the <tt>params[:id]</tt> parameter.
  def show
    id = params[:id]

    check_path! id

    begin
      render :template => "pages/#{id}"
    rescue ActionView::MissingTemplate
      raise create_exception(id)
    end
  end

  private
    # Checks that the page with the specified <tt>id</tt> is valid and does not
    # map to a template outside of the <tt>RAILS_ROOT/app/views/pages</tt>
    # directory. If it does, an exception is thrown.
    def check_path!(id)
      base = File.expand_path('app/views/pages', ::Rails.root.to_s)
      current = File.expand_path(id, base)

      if not current.starts_with? base
        raise create_exception(id)
      end
    end

    # Creates a new <tt>ActionController::RoutingError</tt> for the page with
    # the specified <tt>id</tt>.
    def create_exception(id)
      ActionController::RoutingError.new "No static route matches \"#{page_path id}\""
    end
end
