class BadgesController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    @badge = Badge.create(badge_params)
    redirect_to badges_path
  end

  def index
  end

  def edit
  end

  def destroy
    @badge.destroy
    flash[:error] = "Badge destroyed"
    redirect_to badges_path
  end
  
  private
    def badge_params
      params.require(:badge).permit(:name, :image)
    end
end
