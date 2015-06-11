require 'spec_helper'

describe SessionsController do
  describe "POST checking_credentials" do
    it "should set session when correct info given" do
      user = Fabricate(:user)
      post :checking_credentials, username: user.username, password: user.password
      expect(session[:user_id]).to eq(user.id)
    end
  end
end