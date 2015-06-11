require 'spec_helper'

describe QueueItem do
  it {should belong_to(:user)}
  it {should belong_to(:video)}

  describe "#video_title" do
    it "should get the video title for that queue item" do
      user = Fabricate(:user)
      vid = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: vid)
      expect(queue_item.video_title).to eq(vid.title)
    end 
  end

  describe "#video_rating" do
    it "should get the video rating for that queue item" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.video_rating).to eq(video.reviews.first.rating)      
    end
  end

  describe "#video_rating=" do
    it "updates the video rating if present" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, video: video, user: user, rating: 4)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.video_rating=1
      queue_item.save
      expect(queue_item.video_rating).to eq(1)      
    end
    it "creates new rating if rating does not exist" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.video_rating=1
      queue_item.save
      expect(QueueItem.first.video_rating).to eq(1)       
    end
  end

  describe "#video_category" do
    it "should get the video category for that queue item" do
      user = Fabricate(:user)
      category = Category.create(name: "Sports")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.video_category).to eq(video.category.name)       
    end
  end

  #  describe 'self.correct_positions' do
  #  let(:user) { Fabricate(:user)}
  #  let(:video1) {Fabricate(:video)}
  #  let(:video2) {Fabricate(:video)}
  #  let(:video3) {Fabricate(:video)}
  #  let(:queue_item1) {Fabricate(:queue_item, video: video1, user: user, position: 1)}
  #  let(:queue_item2) {Fabricate(:queue_item, video: video2, user: user, position: 2)}
  #  let(:queue_item3) {Fabricate(:queue_item, video: video3, user: user, position: 4)}
  #    it "should change the position of all incorrect queue items by -1" do
  #      QueueItem.correct_positions
  #      expect(queue_item3.position).to eq(3)
  #    end
  #    it "should not change the position other queue items" do
  #      QueueItem.correct_positions
  #      expect(queue_item2.position).to eq(2)
  #    end 
end