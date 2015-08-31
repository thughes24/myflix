Rails.configuration.stripe = {
  :publishable_key => ENV['stripe_publishable_key'],
  :secret_key => ENV['stripe_secret_key']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    Payment.create(amount: event.data.object.amount, reference_id: event.data.object.id, user: User.where(customer_token: event.data.object.customer).first)
  end

  events.subscribe 'charge.failed' do |event|
    user = User.where(customer_token: event.data.object.customer).first
    user.deactivate!
  end
end