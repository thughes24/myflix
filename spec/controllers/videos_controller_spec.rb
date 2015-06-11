require 'spec_helper'

describe VideosController do
  context "with logged in user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
    describe "GET show" do
      it "assigns @video variable" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
      it "renders :show template" do
        video = Fabricate(:video)
        get :show, id: video.id
        response.should render_template :show
      end

      it "sets the @review variable" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:review)).to be_new_record
      end
    end
  
    describe "GET search" do
      it "assigns @videos variable to search result" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        video3 = Fabricate(:video)
        get :search, search: video1.title
        expect(assigns(:videos)).to eq([video1])
      end
      it "renders search template" do
        get :search, search: " "
        expect(response).to render_template :search
      end
    end
  end
end