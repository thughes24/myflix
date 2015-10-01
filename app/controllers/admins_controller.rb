class AdminsController < ApplicationController
  before_action do |c|
    c.available_to("logged_in")    
  end
  before_action :ensure_admin

  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end