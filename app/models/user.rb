class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items
  has_many :follows
  has_many :following, through: :follows
  has_many :inverse_follows, class_name: 'Follow', foreign_key: "follower_id"
  has_many :followers, through: :inverse_follows, source: :user

  has_many :invites, foreign_key: "inviter_id"
  has_many :inverse_invites, class_name: "Invite", foreign_key: "invited_id"
  has_many :inviters, through: :invites
  has_many :inviteds, through: :inverse_invites, source: :inviter
  has_secure_password
  validates_presence_of :username, :email

  def has_queued_video?(vid)
    queue_items.map(&:video).include?(vid)
  end

  def generate_reset_token
    self.reset_token = SecureRandom.urlsafe_base64
  end

  def self.create_mutual_follow(user, user1)
    Follow.create(user_id: user.id, follower_id: user1.id)
    Follow.create(user_id: user1.id, follower_id: user.id)
  end

  def deactivate!
    update_column(:active, false)
  end
end