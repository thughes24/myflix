class AppMailer < ActionMailer::Base
  default from: "shortspots@gmail.com"
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to MyFlix!")
  end
end