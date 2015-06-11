class ReviewsController < ApplicationController
before_action { |c| c.available_to 'logged_in'}
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.video_id = params[:video_id]
    if @review.save
      flash[:notice] = "Review Posted"
      redirect_to video_path(params[:video_id])
    else
      render '/videos/show'
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating,:writeup)
  end
end