class FollowsController < ApplicationController
  before_action do |c| 
    c.available_to "logged_in"
  end
  def create
    @follow = Follow.new(user: current_user, following: User.find(params[:user_id]))
    if @follow.save
      redirect_to people_path
    else
      redirect_to people_path
    end
  end

  def destroy
    current_user.follows.find(params[:id]).delete
    redirect_to people_path
  end
end