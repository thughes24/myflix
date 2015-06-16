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
      if params[:invite_token]
        @user1 = Invite.find_by_invite_token(params[:invite_token]).inviter
        User.create_mutual_follow(@user,@user1)
      end
      AppMailer.welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def people
    @user = current_user
  end

  def password_reset
    if params[:email]
      @user = User.find_by_email(params[:email])
      if @user
        @user.generate_reset_token
        if @user.save
          redirect_to confirm_password_reset_path if AppMailer.password_reset_token(@user).deliver
        end
      else
        flash[:error] = "No user with that email exists"
        render :password_reset
      end
    end
  end

  def confirm_password_reset
  end

  def new_password
    @user = User.find_by_reset_token(params[:reset_token])
    redirect_to invalid_token_path if params[:reset_token].blank? || !@user
  end

  def invalid_token
  end

  def create_password
    @user = User.find_by_reset_token(params[:token])
    @user.password = params[:password]
    if @user.save
      @user.update(reset_token: nil)
      redirect_to sign_in_path
    else
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email,:username,:password)
  end
end