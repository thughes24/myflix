class Video < ActiveRecord::Base
  has_many :reviews
  belongs_to :category
  validates :title, presence: true
  validates :description, presence: true
  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader
  
  def self.search_by_title(vid_title)
    return [] if vid_title.blank?
    videos = Video.where("title like ?", "%#{vid_title}%").order("created_at DESC")
  end 
end