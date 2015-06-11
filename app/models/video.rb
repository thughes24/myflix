class Video < ActiveRecord::Base
  has_many :reviews
  belongs_to :category
  validates :title, presence: true
  validates :description, presence: true
  
  def self.search_by_title(vid_title)
    return [] if vid_title.blank?
    videos = Video.where("title like ?", "%#{vid_title}%").order("created_at DESC")
  end 

  def average_rating
    if reviews.size > 0
      ugly_result = total_sum_of_reviews / reviews.size
      "Average Rating: #{make_decimals_pretty(ugly_result)} / 5"
    else
      "No Reviews"
    end
  end

  private
  def total_sum_of_reviews
    count = 0.0
    reviews.each { |review| count += review.rating }
    count
  end

  def make_decimals_pretty(ugly_decimal)
    ugly_decimal.round(1)
  end
end