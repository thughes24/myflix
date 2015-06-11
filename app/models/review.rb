class Review < ActiveRecord::Base
  default_scope { order(created_at: :desc)}
  belongs_to :user
  belongs_to :video
  validates :writeup, presence: true
  validates :rating, presence: true
end 