class UsersController < ApplicationController
  #before_action :logged_out_access_only, only: [:new]
  before_action except: [:show,:people] do |c| 
    c.available_to "logged_out"
  end
  before_action only: [:show,:people] do |c| 
    c.available_to "logged_in"
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      AppMailer.welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def people
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:email,:username,:password)
  end
end