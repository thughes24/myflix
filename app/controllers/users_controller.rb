class UsersController < ApplicationController
  #before_action :logged_out_access_only, only: [:new]
  before_action { |c| c.available_to "logged_out"}
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to sign_in_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email,:username,:password)
  end
end