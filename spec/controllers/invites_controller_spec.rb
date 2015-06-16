require 'spec_helper'

describe InvitesController do
  describe 'GET new' do
    it "sets new @invite variable" do
      get :new
      expect(assigns(:invite)).to be_new_record
    end
  end

  describe "POST create" do
    before do
      user = Fabricate(:user)
      session[:user_id] = user.id
    end
    it "hits the db with invite_token" do
      post :create, email: 'john@example.com', message: "hello hi", name: "john"
      expect(Invite.first.invite_token).not_to be_nil
    end
    it "hits the db with correct user & inviter association" do
      post :create, email: 'john@example.com', message: "hello hi", name: "john"
      expect(Invite.first.invited_email).to eq('john@example.com')
    end
  end
end