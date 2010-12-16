require 'ignition'

module Ignition
  # A Rails controller which maps static content to actual template files in the
  # <tt>RAILS_ROOT/app/views/pages</tt> directory.
  class PagesController < ApplicationController
    # Creates the controller.
    def initialize
      super

      case Ignition::Configuration.caching_method
      when :page then
        caches_page :show
      when :page_without_layout then
        caches_action :show, :layout => false
      when :none then
        # do nothing
      else
        raise "Invalid caching method: #{caching_method}"
      end
    end

    # Shows the page specified by the <tt>params[:id]</tt> parameter.
    def show
      id = params[:id]
      render :template => "#{Ignition::PAGES_DIRECTORY}/#{id}"
    end
  end
end
