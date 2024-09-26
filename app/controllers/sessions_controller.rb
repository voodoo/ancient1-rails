class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_by(email: params[:email].downcase)
    user.generate_login_token
    AuthMailer.login_link(user).deliver_later
    redirect_to root_path, notice: "Login link sent to your email."
  end

  def login
    user = User.find_by(login_token: params[:token])
    if user&.valid_login_token?(params[:token])
      session[:user_id] = user.id
      user.clear_login_token
      redirect_to root_path, notice: "Logged in successfully!"
    else
      redirect_to login_path, alert: "Invalid or expired login link."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end