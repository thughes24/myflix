require 'spec_helper'

describe FollowsController do
  describe "POST create" do
    it "redirects to landing when logged out" do
      post :create, user_id: 2
      expect(response).to redirect_to root_path
    end

    it "sets the current user to follow the user on page" do
      user = Fabricate(:user)
      steve = Fabricate(:user)
      session[:user_id] = user.id
      post :create, user_id: steve.id
      expect(user.following.count).to eq(1)
    end
  end

  describe "DELETE destroy" do
    it "unfollows the user" do
      user = Fabricate(:user)
      steve = Fabricate(:user)
      session[:user_id] = user.id
      follow = Follow.create(user: user, following: steve)
      delete :destroy, user_id: steve.id, id: follow.id
      expect(user.following.count).to eq(0)
    end
  end
end