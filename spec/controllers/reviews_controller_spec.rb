require 'spec_helper'

describe ReviewsController do
  context "with logged in user" do
      before do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
      end
    describe "POST create" do
      context "input valid" do
        it "submits review to database" do
          video = Fabricate(:video)
          post :create, review: {rating: 3,writeup: "test writeup"}, video_id: video.id
          expect(Review.all.count).to eq 1
        end 
        it "associates the review with the current user" do
          video = Fabricate(:video)
          post :create, review: {rating: 3,writeup: "test writeup"}, video_id: video.id
          expect(Review.first.user).to eq @user
        end
        it "associates the review with the video shown" do
          video = Fabricate(:video)
          post :create, review: {rating: 3,writeup: "test writeup"}, video_id: video.id
          expect(Review.first.video).to eq video
        end
      end
      context "invalid input" do
        it "should render the template" do
          video = Fabricate(:video)
          post :create, review: {rating: 3}, video_id: video.id
          expect(response).to render_template 'videos/show'
        end
      end
    end
  end
  context "with logged out user" do
    describe "POST create" do
      it 'should redirect to home page' do
        video = Fabricate(:video)
        post :create, review: {rating: 3,writeup: "test writeup"}, video_id: video.id
        expect(response).to redirect_to root_path
      end
    end
  end
end