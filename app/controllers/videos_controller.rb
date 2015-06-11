class VideosController < ApplicationController
  #before_action :logged_in_access_only, except: :landing
  #before_action :logged_out_access_only, only: :landing
  before_action { |c| c.available_to 'logged_in'}

  def home
    @categories = Category.all
  end
  def show
    @video = Video.find(params[:id])
    @review = Review.new
  end

  def search
    @videos = Video.search_by_title(params[:search])
    flash[:notice] = "No Videos Found" if @videos == []
  end
end 