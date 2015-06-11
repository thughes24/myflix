class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  default_scope { order(position: :asc)}
  validates_numericality_of :position, only_integer: true

  def video_title
    video.title
  end

  def video_rating
    review = find_review
    review.rating if review
  end 

  def video_category
    video.category.name
  end

  def video_rating=(new_rating)
    review = find_review
    if review
      review.update(rating: new_rating)
    else
      review = Review.new(rating: new_rating, video: video, user: user)
      review.save(validate: false)
    end
  end

  def self.correct_positions
    actual_positions = QueueItem.all.map do |item|
      item.position
    end
    correct_positions = [*1..QueueItem.all.count]
    difference = correct_positions.map.with_index do |correct_position,i|
      actual_positions[i] - correct_position
    end
    array_of_queue_item_objects = QueueItem.all.map {|x| x}
    array_of_queue_item_objects.each_with_index do |queue_item, i|
      queue_item.update(position: (queue_item.position - difference[i]))
    end
  end

  private
  def find_review
    video.reviews.where(user: user.id).first 
  end
end