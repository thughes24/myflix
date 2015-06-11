class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :following, class_name: "User", foreign_key: 'follower_id'
end