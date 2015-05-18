class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
 
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

#  def logged_in_access_only
#    if session[:user_id].blank?
#      flash[:notice] = "You need to be logged in to access that feature"
#      redirect_to root_path
#    end
#  end
#  def logged_out_access_only
#    redirect_to home_path if current_user
#  end

  def available_to(who)
    case who
    when 'logged_in' then redirect_to root_path if !current_user
    when 'logged_out' then redirect_to home_path if current_user
    end
  end
end
