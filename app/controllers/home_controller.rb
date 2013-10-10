class HomeController < ApplicationController
  def index
    @badges = Badge.all
    @badges = @badges[0..4] #TODO: randomize this offset
  end
end
