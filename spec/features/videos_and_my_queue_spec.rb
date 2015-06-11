require 'spec_helper'

feature "My Queue and Videos Integration" do
  given(:user) { Fabricate(:user) }

  scenario "everything in one" do
    category = Fabricate(:category)
    video1 = Fabricate(:video, category: category)
    video2 = Fabricate(:video, category: category)
    video3 = Fabricate(:video, category: category)
    visit "/sign-in"
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button('Log In')
    expect(page).to have_content(user.username)

    visit "/home"
    find("a[href='/videos/#{video1.id}']").click
    expect(page).to have_content(video1.title)

    click_link("+ My Queue")
    expect(page).to have_content(video1.title)

    visit video_path(video1)
    expect(page).to have_no_content("+ My Queue")

    visit '/home'
    find("a[href='/videos/#{video2.id}']").click
    click_link("+ My Queue")

    visit '/home'
    find("a[href='/videos/#{video3.id}']").click
    click_link("+ My Queue")
    expect(page).to have_content(video3.title)

    fill_in("video_#{video1.id}", with: '5')
    click_button "Update Instant Queue"
    expect(find_field("video_#{video1.id}").value).to eq '3'
  end
end