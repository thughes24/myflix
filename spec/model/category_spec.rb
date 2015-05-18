require 'spec_helper'

describe Category do
  it { should have_many(:videos)}


describe 'recent_videos' do
  it "should load all videos in category if less than 6 videos in category" do
    sports = Category.create(name: 'sports')
    video1 = Video.create(title: 'video1', description: "some_desc", category: sports)
    video2 = Video.create(title: 'video2', description: "some_desc", category: sports)
    video3 = Video.create(title: 'video3', description: "some_desc", category: sports)
    expect(sports.recent_videos).to include(video3,video2,video1)
  end
  it "should load the most recent 6 videos if more than 6 videos in category" do
    sports = Category.create(name: 'sports')
    video1 = Video.create(title: 'video1', description: "some_desc", category: sports)
    video2 = Video.create(title: 'video2', description: "some_desc", category: sports)
    video3 = Video.create(title: 'video3', description: "some_desc", category: sports)
    video4 = Video.create(title: 'video4', description: "some_desc", category: sports)
    video5 = Video.create(title: 'video5', description: "some_desc", category: sports)
    video6 = Video.create(title: 'video6', description: "some_desc", category: sports)
    video7 = Video.create(title: 'video7', description: "some_desc", category: sports)
    expect(sports.recent_videos).to eq([video7,video6,video5,video4,video3,video2])
  end
  it "shoud display the videos in reverse chronological order" do
    sports = Category.create(name: 'sports')
    video1 = Video.create(title: 'video1', description: "some_desc", category: sports)
    video2 = Video.create(title: 'video2', description: "some_desc", category: sports)
    video3 = Video.create(title: 'video3', description: "some_desc", category: sports)
    expect(sports.recent_videos).to eq([video3,video2,video1])
  end
end
end