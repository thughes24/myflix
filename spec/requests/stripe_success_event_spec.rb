require 'spec_helper'

describe "Creates Payment on Successful Charge" do
  let( :event_data) do
      {
  "id" => "evt_16fbxpKvv4sqfP0NTRZc1sEK",
  "created" => 1440964781,
  "livemode" => false,
  "type" => "charge.succeeded",
  "data" => {
    "object" => {
      "id" => "ch_16fbxpKvv4sqfP0NOYz3zAF7",
      "object" => "charge",
      "created" => 1440964781,
      "livemode" => false,
      "paid" => true,
      "status" => "succeeded",
      "amount" => 999,
      "currency" => "usd",
      "refunded" => false,
      "source" => {
        "id" => "card_16fbxoKvv4sqfP0NapZVOmQV",
        "object" => "card",
        "last4" => "4242",
        "brand" => "Visa",
        "funding" => "credit",
        "exp_month" => 8,
        "exp_year" => 2017,
        "fingerprint" => "WUS6lmDVZLbIK3fX",
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
        "customer" => "cus_6tOlqdLKvcWzyN"
      },
      "captured" => true,
      "balance_transaction" => "txn_16fbxpKvv4sqfP0NYyZeVK8I",
      "failure_message" => nil,
      "failure_code" => nil,
      "amount_refunded" => 0,
      "customer" => "cus_6tOlqdLKvcWzyN",
      "invoice" => "in_16fbxpKvv4sqfP0Nz03D1lVQ",
      "description" => nil,
      "dispute" => nil,
      "metadata" => {},
      "statement_descriptor" => "MyFlix Int. Billing",
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
        "url" => "/v1/charges/ch_16fbxpKvv4sqfP0NOYz3zAF7/refunds",
        "data" => []
      }
    }
  },
  "object" => "event",
  "pending_webhooks" => 1,
  "request" => "req_6tOlxi1rUtkZxm",
  "api_version" => "2015-06-15"
  }
  end

  it "creates a payment with stipe webhook data on successful charge", :vcr do
    post '/stripe_events', event_data
    expect(Payment.count).to eq(1)
  end

  it "sets the payment amount", :vcr do
    post '/stripe_events', event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "sets the reference id", :vcr do
    post '/stripe_events', event_data
    expect(Payment.first.reference_id).to eq("ch_16fbxpKvv4sqfP0NOYz3zAF7")
  end 

  it "associates the user with the payment", :vcr do
    rohan = Fabricate(:user, customer_token: "cus_6tOlqdLKvcWzyN")
    post '/stripe_events', event_data
    expect(Payment.first.user).to eq(rohan)
  end
end