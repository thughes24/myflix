require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_new_record
    end
  end

  describe "POST create" do
    context "with successful sign_up" do
      it "redirects to the sign in path" do
        result = double(:user_reg, successful?: true)
        UserRegistration.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: {email: "example@gmail.com", username: "username", password: "password"}
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with unsuccessful sign_up" do
      let(:result) { result = double(:user_reg, successful?: false, error_message: "some error eeek") }
      it "renders the new template" do
        UserRegistration.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: "12345"
        expect(response).to render_template(:new)
      end
      it "displays error message from service object" do
        UserRegistration.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: "12345"
        expect(flash[:error]).to eq("some error eeek")
      end
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

  describe 'GET forgot_password' do
    context 'email param not set' do
      it 'renders the page if no email is set' do
        get :password_reset
        expect(response).to render_template :password_reset
      end
    end
    context 'email param is set' do
      before do
        @user = Fabricate(:user)
      end
      it 'flash errors "no email exists" if invalid set email' do
        get :password_reset, email: 'toot@example.com'
        expect(flash[:error]).to eq("No user with that email exists")
      end
      it 'sets reset token for valid email' do
        get :password_reset, email: @user.email
        expect(User.first.reset_token).not_to be_empty
      end
      it 'emails the address with reset token link' do
        get :password_reset, email: @user.email
        expect(ActionMailer::Base.deliveries.last).to have_content(@user.reset_token)
      end
      it 'redirects to the confirmation page once email is sent' do
        get :password_reset, email: @user.email
        expect(response).to redirect_to confirm_password_reset_path
      end
    end
  end

  describe 'GET new_password' do
    it "redirects to invalid_token_path if reset_token param is not set" do
      get :new_password
      expect(response).to redirect_to invalid_token_path
    end
    it "redirects to invalid_token_path if token does not match any email" do
      get :new_password, reset_token: "dnkl3sna34"
      expect(response).to redirect_to invalid_token_path
    end
    it "finds the user by the reset token" do
      user = User.create(username: 'tom', email: 'bob@gmail.com', password: 'poop', reset_token: 'werty')
      get :new_password, reset_token: user.reset_token
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST create_password' do
    it "finds the user by the reset token" do
      user = Fabricate(:user)
      post :create_password, reset_token: user.reset_token, password: user.password
      expect(assigns(:user)).to eq(user)
    end
    it "sets the new users password" do
      user = Fabricate(:user)
      post :create_password, reset_token: user.reset_token, password: "cats"
      expect(User.first.authenticate("cats")).to be_truthy
    end
    it "destroys the reset token once password is reset" do
      user = Fabricate(:user)
      post :create_password, reset_token: user.reset_token, password: "cats"
      expect(User.first.reset_token).to be_blank
    end
    it "redirects to sign_in page when password reset" do
      user = Fabricate(:user)
      post :create_password, reset_token: user.reset_token, password: "cats"
      expect(response).to redirect_to sign_in_path
    end
  end
end