class BadgesController < ApplicationController
  load_and_authorize_resource :except => :create

  def new
  end

  def create
    @badge = Badge.create(badge_params)
    redirect_to badges_path
  end

  def show
    @percent = @badge.achievements.count / User.all.count
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
      params.require(:badge).permit!
    end
end
