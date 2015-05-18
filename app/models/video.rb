class Video < ActiveRecord::Base
belongs_to :category
validates :title, presence: true
validates :description, presence: true

def self.search_by_title(vid_title)
  return [] if vid_title.blank?
  videos = Video.where("title like ?", "%#{vid_title}%").order("created_at DESC")
end 
end