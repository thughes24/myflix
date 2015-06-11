require 'spec_helper'

describe User do
  it {should have_many(:follows)}
  it {should have_many(:followers).through(:follows)}
  describe "#has_queued_video?" do
    it "returns true if video is already in current users queue" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      user.has_queued_video?(video).should be_truthy 
    end
    it "returns false if video is not in the current users queue" do
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user2)
      user.has_queued_video?(video).should be false
    end
  end
end