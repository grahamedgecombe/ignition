class DynamicController < ApplicationController
  def time
    @time = Time.now
  end
end
