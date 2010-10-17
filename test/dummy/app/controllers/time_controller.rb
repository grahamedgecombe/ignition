class TimeController < ApplicationController
  def now
    @time = Time.now
  end
end
