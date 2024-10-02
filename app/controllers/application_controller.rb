class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :logged_in?, :authenticate_user!, :current_user
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    rescue ActiveRecord::RecordNotFound
      @current_user = nil
      session[:user_id] =  nil
    end
  end

  def authenticate_user!
    redirect_to login_path, alert: 'You must be logged in to submit a link.' unless logged_in?
  end  
end
