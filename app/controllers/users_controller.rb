class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:settings]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
