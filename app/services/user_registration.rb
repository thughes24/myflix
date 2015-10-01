class UserRegistration
  attr_accessor :user, :status, :error_message
  def initialize(user)
    @user = user
  end


  def sign_up(stripe_token,invite_token)
    if user.valid?
      customer = StripeWrapper::Customer.create(
        user: user,
        description: "Monthly Myflix Payment",
        card: stripe_token,
        )
      if customer.successful?
        user.customer_token = customer.customer_token
        user.save
        if invite_token
          @user1 = Invite.find_by_invite_token(invite_token).inviter
          User.create_mutual_follow(user,@user1)
        end
        AppMailer.delay.welcome_email(user)
        @status = :success
        self
      else
        @error_message = customer.error_message
        @status = :fail
        self
      end
    else
      @error_message = "Please enter valid personal details"
      @status = :fail
      self
    end
  end

  def successful?
    status == :success
  end
end