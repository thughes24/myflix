class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items
  has_many :follows
  has_many :following, through: :follows
  has_many :inverse_follows, class_name: 'Follow', foreign_key: "follower_id"
  has_many :followers, through: :inverse_follows, source: :user
  has_secure_password
  validates_presence_of :username, :email

  def has_queued_video?(vid)
    queue_items.map(&:video).include?(vid)
  end

  def generate_reset_token
    self.reset_token = SecureRandom.urlsafe_base64
  end
end