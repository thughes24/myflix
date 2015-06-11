require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_new_record
    end
  end

  describe "POST create" do
    it "creates new @user is all input is valid" do
      post :create, user: {email: "example@gmail.com", username: "username", password: "password"}
      expect(User.all.count).to eq(1)
    end
    it "renders template when input is invalid" do
      post :create, user: {email: "email@email.com"}
      expect(response).to render_template :new
    end
  end

  describe 'GET show' do
    it "loads the @user based on the id" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end