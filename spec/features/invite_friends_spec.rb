require 'spec_helper'

feature "User can invite friends" do
  scenario "User invites friends" do
    user = Fabricate(:user)
    visit '/sign-in'
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button("Log In")
    expect(page).to have_content(user.username)
    click_link("Welcome, #{user.username}")
    click_link("Invite Friends")
    fill_in "Name", with: "John"
    fill_in "Email", with: "john@example.com"
    fill_in "Message", with: "Join this really cool site!"
    click_button("Send Invitation")
    click_link("Welcome, #{user.username}")
    click_link("Logout")

    open_email("john@example.com")
    current_email.click_link("Join MyFlix")
    expect(page).to have_button("Sign Up")
    expect(page).to have_selector("input[value='john@example.com']")

    fill_in "Username", with: "John"
    fill_in "Password", with: "password"
    click_button("Sign Up")
    visit '/sign-in'
    fill_in "Username", with: 'John'
    fill_in "Password", with: 'password'
    click_button("Log In")
    
    visit '/people'
    expect(page).to have_content(user.username)

    click_link("Welcome, #{User.second.username}")
    click_link("Logout")

    visit '/sign-in'
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button("Log In")
    expect(page).to have_content(user.username)

    visit '/people'
    expect(page).to have_content("John")
  end
end