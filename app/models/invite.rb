class Invite < ActiveRecord::Base
  belongs_to :inviter, class_name: 'User'

  def add_invite_token
    self.invite_token = SecureRandom.urlsafe_base64
  end

end