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
    @user = User.find_by(params[:id])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :sign_in
    end
  end

end