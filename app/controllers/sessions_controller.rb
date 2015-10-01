class SessionsController < ApplicationController
  
  before_action only: :sign_in do |c| 
    c.available_to "logged_out"
  end

  def sign_in
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def checking_credentials
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      if @user.active == false
        flash[:error] = "Your account has been suspended, please contact support."
        redirect_to sign_in_path
      else
        session[:user_id] = @user.id
        redirect_to home_path
      end
    else
      flash[:notice] = "Invalid Username/Password"
      render :sign_in
    end
  end

end