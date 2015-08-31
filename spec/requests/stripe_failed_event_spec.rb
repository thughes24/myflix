require 'spec_helper'

describe "Stripe Failed Event" do
  let(:event_data) do
    {
  "id" => "evt_16ffqrKvv4sqfP0N7c1VtQYK",
  "created" => 1440979725,
  "livemode" => false,
  "type" => "charge.failed",
  "data" => {
    "object" => {
      "id" => "ch_16ffqrKvv4sqfP0NnQIu7Dcs",
      "object" => "charge",
      "created" => 1440979725,
      "livemode" => false,
      "paid" => false,
      "status" => "failed",
      "amount" => 999,
      "currency" => "usd",
      "refunded" => false,
      "source" => {
        "id" => "card_16ffqMKvv4sqfP0NU01rI9zj",
        "object" => "card",
        "last4" => "0341",
        "brand" => "Visa",
        "funding" => "credit",
        "exp_month" => 8,
        "exp_year" => 2017,
        "fingerprint" => "6Adws3FTTGWHEppr",
        "country" => "US",
        "name" => nil,
        "address_line1" => nil,
        "address_line2" => nil,
        "address_city" => nil,
        "address_state" => nil,
        "address_zip" => nil,
        "address_country" => nil,
        "cvc_check" => "pass",
        "address_line1_check" => nil,
        "address_zip_check" => nil,
        "tokenization_method" => nil,
        "dynamic_last4" => nil,
        "metadata" => {},
        "customer" => "cus_6tQJcgdxE0Xm7y"
      },
      "captured" => false,
      "balance_transaction" => nil,
      "failure_message" => "Your card was declined.",
      "failure_code" => "card_declined",
      "amount_refunded" => 0,
      "customer" => "cus_6tQJcgdxE0Xm7y",
      "invoice" => nil,
      "description" => "fail bitch",
      "dispute" => nil,
      "metadata" => {},
      "statement_descriptor" => nil,
      "fraud_details" => {},
      "receipt_email" => nil,
      "receipt_number" => nil,
      "shipping" => nil,
      "destination" => nil,
      "application_fee" => nil,
      "refunds" => {
        "object" => "list",
        "total_count" => 0,
        "has_more" => false,
        "url" => "/v1/charges/ch_16ffqrKvv4sqfP0NnQIu7Dcs/refunds",
        "data" => []
      }
    }
  },
  "object" => "event",
  "pending_webhooks" => 1,
  "request" => "req_6tSmhdYEEDMxmU",
  "api_version" => "2015-06-15"
}
  end

  it "deactivates the user upon failed charge", :vcr do
    user = Fabricate(:user, active: true, customer_token: "cus_6tQJcgdxE0Xm7y")
    post "/stripe_events", event_data
    expect(user.reload).not_to be_active
  end
end