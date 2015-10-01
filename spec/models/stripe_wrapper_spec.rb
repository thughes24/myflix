require 'spec_helper'

describe StripeWrapper do
  before { Stripe.api_key = ENV["stripe_secret_key"] }
  let(:token) do
    Stripe::Token.create(
      card: {
        number: card_number,
        exp_month: 6,
        exp_year: 2018,
        cvc: 314
      }).id
  end
  describe StripeWrapper::Charge do
    describe ".create" do
      context "with valid card", :vcr do
        let(:card_number) { '4242424242424242' }
        it "makes a successful charge" do
          charge = StripeWrapper::Charge.create(amount: 300, card: token)
          expect(charge).to be_successful
        end
      end

      context "with invalid card", :vcr do
        let(:card_number) { '4000000000000002' }
        let(:response) { StripeWrapper::Charge.create(amount: 400, card: token) }
        it "does not make a successful charge" do
          expect(response).not_to be_successful
        end
        it "contains an error message" do
          expect(response.error_message).to be_present
        end
      end
    end
  end

  describe StripeWrapper::Customer do
    describe ".create" do
      context "with valid card", :vcr do
        let(:card_number) { '4242424242424242' }
        let(:joe) { Fabricate(:user)}
        it "creates a customer" do
          response = StripeWrapper::Customer.create(user: joe, card: token)
          expect(response).to be_successful
        end

        it "returns the customer token", :vcr do
          response = StripeWrapper::Customer.create(user: joe, card: token)
          expect(response.customer_token).to be_present
        end
      end
  
      context "with invalid card", :vcr do
        let(:card_number) { '4000000000000002' }
        let(:joe) { Fabricate(:user)}
        it "does not create a customer" do
          customer = StripeWrapper::Customer.create(user: joe, plan: "base", card: token)
          expect(customer).not_to be_successful
        end
        it "recieves the error message from stripe" do
          customer = StripeWrapper::Customer.create(user: joe, plan: "base", card: token)
          expect(customer.error_message).to eq("Your card was declined.")
        end
      end
    end
  end
end