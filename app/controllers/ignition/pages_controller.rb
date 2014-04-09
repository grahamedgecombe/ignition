module Ignition
  class PagesController < ApplicationController
    layout Rails.application.config.ignition.layout

    case Rails.application.config.ignition.cache
    when :page then
      caches_page :show
    when :page_without_layout then
      caches_action :show, :layout => false
    when :none then
      # do nothing
    else
      raise "Invalid caching method: #{Rails.application.config.ignition.cache}"
    end

    def show
      id = params[:id]
      render :template => "#{Rails.application.config.ignition.view_prefix}/#{id}"
    end
  end
end
