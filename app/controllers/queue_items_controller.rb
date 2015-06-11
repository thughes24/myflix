class QueueItemsController < ApplicationController
before_action { |c| c.available_to "logged_in"}
  def index
    @queue_items = current_user.queue_items
  end

  def create
    item_position = QueueItem.all.where(user_id: current_user.id).count + 1
    queue_item = QueueItem.create(video_id: params[:format], position: item_position, user_id: current_user.id)
    redirect_to my_queue_path
  end

  def destroy   
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy
    QueueItem.correct_positions
    redirect_to my_queue_path
  end

  def update_queue
    ActiveRecord::Base.transaction do
      begin   
        params[:queue_items].each do |queue_item_data|
          queue_item = QueueItem.find(queue_item_data["id"])
          queue_item.update!(position: queue_item_data["position"], video_rating: queue_item_data["rating"])
        end
      rescue ActiveRecord::RecordInvalid
        flash[:error] = "Invalid Position Number"
        redirect_to my_queue_path
        return
      end
    end
    QueueItem.correct_positions
    redirect_to my_queue_path
  end
end