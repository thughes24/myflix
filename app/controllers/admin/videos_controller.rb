class Admin::VideosController < AdminsController
  def new
    @video = Video.new
  end

  def create
    binding.pry
    @video = Video.new(video_params)
    if @video.save
      flash[:notice] = "Video Successfully Posted!"
      redirect_to new_admin_video_path
    else
      flash[:notice] = "Video not posted, please check errors"
      render :new
    end
  end

  private
  def video_params
    params.require(:video).permit!
  end
end