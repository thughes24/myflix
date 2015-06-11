require 'spec_helper'

describe QueueItemsController do
  before { set_user_and_session }
  describe "GET index" do
    it "sets @queue_items if user is logged in" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item1 = Fabricate(:queue_item, user: user)
      queue_item2 = Fabricate(:queue_item, user: user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1,queue_item2])
    end
      it_behaves_like "redirects to root if logged out" do
        let(:action) { get :index}
      end
  end

  describe "POST create" do
    context 'authenticated user' do
      before do
        user = Fabricate(:user)
        session[:user_id] = user.id
      end
      it "hits the db with valid input" do
        video = Fabricate(:video)
        post :create, format: video.id
        expect(QueueItem.all.count).to eq 1
      end
      it "redirects to my queue page" do
        video = Fabricate(:video)
        post :create, format: video.id
        expect(response).to redirect_to my_queue_path
      end
    end
  end

  describe "POST update_queue" do
    context "With unauthenticated user" do
      it "does not change the positions" do
        clear_session
        queue_item1 = Fabricate(:queue_item, position: 1)
        queue_item2 = Fabricate(:queue_item, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(QueueItem.all).to eq([queue_item1,queue_item2])
      end

      it_behaves_like "redirects to root if logged out" do
        let(:action) { post :update_queue}
      end
    end
    context "With valid inputs" do

      it "redirects to the my_queue_path" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, position: 1, user: user, video: video)
        queue_item2 = Fabricate(:queue_item, position: 2, user: user, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "updates the queue item positions" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, position: 1, user: user, video: video)
        queue_item2 = Fabricate(:queue_item, position: 2, user: user, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(QueueItem.all).to eq([queue_item2,queue_item1])      
      end

      it "normalizes the queue item positions" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, position: 1, user: user, video: video)
        queue_item2 = Fabricate(:queue_item, position: 2, user: user, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 7}, {id: queue_item2.id, position: 1}]
        expect(QueueItem.last.position).to eq(2) 
      end

      #it "updates the video review" do
      #  user = Fabricate(:user)
      #  session[:user_id] = user.id
      #  video1 = Fabricate(:video)
      #  review = Fabricate(:review, rating: 3, video: video1, user: user)
      #  video2 = Fabricate(:video)
      #  queue_item1 = Fabricate(:queue_item, video: video1, position: 1, user: user)
      #  queue_item2 = Fabricate(:queue_item, video: video2, position: 2, user: user)
      #  post :update_queue, queue_items: [{id: queue_item1.id, position: 1, rating: 5}, {id: queue_item2.id, position: 1, review: review}]
      #  expect(queue_item1.video_rating).to eq(5)
      #end
    end
    context "With invalid inputs" do
      it "sets flash error message" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, position: 1, user: user, video: video)
        queue_item2 = Fabricate(:queue_item, position: 2, user: user, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.7}, {id: queue_item2.id, position: 1}]
        expect(flash[:error]).to be_present 
      end

      it "does not update queue positions" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, position: 1, user: user, video: video)
        queue_item2 = Fabricate(:queue_item, position: 2, user: user, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.7}, {id: queue_item2.id, position: 1}]
        expect(QueueItem.all).to eq([queue_item1,queue_item2])         
      end

      it "redirects to my_queue_path" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, position: 1, user: user, video: video)
        queue_item2 = Fabricate(:queue_item, position: 2, user: user, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.7}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path     
      end
    end
  end
end