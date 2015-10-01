require 'spec_helper'

describe UserRegistration do

  context "with valid card" do
    before { StripeWrapper::Customer.stub(:create).and_return(customer)}
    let(:customer) { double(:customer, successful?: true, customer_token: "abcdef")}

    it "creates new @user is all input is valid" do
      UserRegistration.new(Fabricate.build(:user)).sign_up("123",nil)
      expect(User.all.count).to eq(1)
    end

    it "sends welcome email" do
      UserRegistration.new(Fabricate.build(:user)).sign_up("123",nil)
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end

    it "sends email to the new user" do
      UserRegistration.new(Fabricate.build(:user, email: "example@gmail.com")).sign_up("123",nil)
      expect(ActionMailer::Base.deliveries.last.to).to eq(["example@gmail.com"])
    end

    it "sends the correct content" do
      UserRegistration.new(Fabricate.build(:user, username: "username")).sign_up("123",nil)
      expect(ActionMailer::Base.deliveries.last.body).to have_content("username")
    end
  end

  context "valid personal info and declined card" do
    before do
      StripeWrapper::Customer.stub(:create).and_return(customer)
    end
    let(:customer) {double(:customer, successful?: false, error_message: "Your card was declined.", customer_token: "abcdef")}
    
    it "does not create a new user" do
      UserRegistration.new(Fabricate.build(:user)).sign_up("123",nil)
      expect(User.count).to eq(0)
    end

    it "displays error message from stripe" do
      result = UserRegistration.new(Fabricate.build(:user)).sign_up("123",nil)
      expect(result.error_message).to be_present
    end
  end

  context "invalid personal info" do
    before do
      StripeWrapper::Customer.stub(:create).and_return(customer)
    end
    let(:customer) {double(:customer, successful?: true, error_message: "Your card was declined.", customer_token: "abcdef")}
    it "does not create a new user" do
      UserRegistration.new(Fabricate.build(:user, email: nil)).sign_up("123",nil)
      expect(User.count).to eq(0)
    end
    it "does not attempt to charge card" do
      UserRegistration.new(Fabricate.build(:user, email: nil)).sign_up("123",nil)
      StripeWrapper::Customer.should_not_receive(:create)
    end
  end
  context "valid personal info and valid card" do
    before do
      StripeWrapper::Customer.stub(:create).and_return(customer)
    end
    let(:customer) {double(:customer, successful?: true, error_message: "Your card was declined.", customer_token: "abcdef")}
    it "creates the new user" do
      UserRegistration.new(Fabricate.build(:user)).sign_up("123",nil)
      expect(User.count).to eq(1)
    end

    it "assigns the customer_token to the user" do
      UserRegistration.new(Fabricate.build(:user)).sign_up("123",nil)
      expect(User.first.customer_token).to eq("abcdef")
    end
  end
end