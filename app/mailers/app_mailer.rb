class AppMailer < ActionMailer::Base
  default from: "shortspots@gmail.com"
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to MyFlix!")
  end

  def password_reset_token(user)
    @user = user
    mail(to: @user.email, subject: "MyFlix: Password Reset Link")
  end

  def send_invite_email(invite)
    @invite = invite
    mail(to: @invite.invited_email, subject: "#{@invite.inviter.username} Invites to Myflix!")
  end
end