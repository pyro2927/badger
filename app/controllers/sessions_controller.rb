class SessionsController < ApplicationController

  def new
    redirect_to '/auth/google_oauth2'
  end


  def create
    auth = request.env["omniauth.auth"]
    if ENV['OMNIAUTH_DOMAIN'] && auth.info.email.split("@").last != ENV['OMNIAUTH_DOMAIN']  
      flash[:error] = auth.info.email + " is not on the required domain"
      redirect_to root_path
      return
    end
    user = User.where(:provider => auth['provider'], 
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
# Reset the session after successful login, per
# 2.8 Session Fixation – Countermeasures:
# http://guides.rubyonrails.org/security.html#session-fixation-countermeasures
    reset_session
    session[:user_id] = user.id
    user.add_role :admin if User.count == 1 # make the first user an admin

    # add default badges to each user
    if user.badges.count == 0
      Badge.where(:default => true).each do |badge|
        ach = Achievement.new
        ach.badge = badge
        ach.user = user
        ach.save
      end
    end

    if user.email.blank?
      redirect_to edit_user_path(user), :alert => "Please enter your email address."
    else
      redirect_to achievements_path, :notice => 'Signed in!'
    end

  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
