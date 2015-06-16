require 'spec_helper'

describe Video do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should belong_to(:category)}

  it "should return an empty array if no vidoe containing string is found" do
    simpsons = Video.create(title: "simpsons", description: "beer")
    south_park = Video.create(title: "south park", description: "silly farts")
    nil_search = Video.search_by_title("fart")
    expect(nil_search).to eq([])
  end

  it "should return a video that the title contains input string" do
    simpsons = Video.create(title: "simpsons", description: "beer")
    south_park = Video.create(title: "south park", description: "silly farts")
    simpsons_search = Video.search_by_title("simpsons")
    expect(simpsons_search).to eq([simpsons])
  end

  it "should return an array of objects if multiple videos are found" do
    simpsons = Video.create(title: "simpsons", description: "beer")
    south_park = Video.create(title: "south park", description: "silly farts")
    s_search = Video.search_by_title("so")
    expect(s_search).to eq([south_park, simpsons])
  end

  it "should return empty array if no search term is entered" do
    expect(Video.search_by_title("")).to eq([])
  end
end