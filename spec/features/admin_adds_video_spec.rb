require 'spec_helper'

feature "Admin adds video" do
  
  scenario "everything in one" do
    user = Fabricate(:user, admin: true)
    category = Fabricate(:category)

    visit '/sign-in'
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button("Log In")

    click_link("Welcome, #{user.username}")
    expect(page).to have_content("Add Video")
    
    click_link("Add Video")
    fill_in "Title", with: "test_title"
    fill_in "Description", with: "test video description"
    select category.name, from: "Category"
    attach_file "Large Cover", "spec/support/monk_large.jpg"
    attach_file "Small Cover", "spec/support/monk.jpg"
    fill_in "Video Url", with: "http://myflixdevelopment.s3.amazonaws.com/uploads/video/HW2%20admin%20adds%20a%20video.mp4"
    click_button "Add Video Now"
    binding.pry
    visit '/home'
    find("a[href='/videos/1']").click
    expect(page).to have_content("test_title")

    click_button("Watch Now")
    expect(page).not_to have_content("VIDEOS")

  end
end
