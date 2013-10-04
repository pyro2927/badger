class AchievementsController < ApplicationController
  def index
    @users = User.all
    authorize! :index, @users
  end

  def create
    user = User.find(params[:user_id])
    authorize! :update, user
    badge = Badge.find(params[:badge_id])
    achievement = Achievement.new
    achievement.user = user
    achievement.badge = badge
    achievement.save
    redirect_to user
  end

  def destroy
    achievement = Achievement.find(params[:id])
    authorize! :destroy, achievement
    @user = achievement.user
    achievement.destroy
    redirect_to @user
  end
end
