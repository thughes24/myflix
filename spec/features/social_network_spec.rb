require 'spec_helper'

feature "Social Network Features" do

  scenario "everything in one" do
    user = Fabricate(:user)
    user2 = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    review = Fabricate(:review, user: user2, video: video)

    visit '/sign-in'
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button("Log In")

    find("a[href='/videos/#{video.id}']").click
    expect(page).to have_content(video.title)

    find("a[href='/users/#{user2.id}']").click
    expect(page).to have_content("#{user2.username}'s video collections")

    find("a[href='/users/#{user2.id}/follows']").click
    expect(page).to have_content(user2.username)

    find("a[href='/users/#{user.id}/follows/#{Follow.first.id}']").click
    expect(page).to have_no_content(user2.username)
  end
end