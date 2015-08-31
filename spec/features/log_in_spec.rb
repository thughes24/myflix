require 'spec_helper'

feature "Log-in to Website" do
  background do
    user = User.create(username: 'demo', password: 'password', email: 'email@gmail.com')
  end
  scenario "correct credentials" do
    visit "/sign-in"
    fill_in 'Username', with: 'demo'
    fill_in 'Password', with: 'password'
    click_button('Log In')
    expect(page).to have_content("demo")
  end

  scenario "unactivated user" do
    unactive = Fabricate(:user, active: false, password: "password")
    visit '/sign-in'
    fill_in 'Username', with: unactive.username
    fill_in 'Password', with: "password"
    click_button('Log In')
    expect(page).to have_content("Your account has been suspended, please contact support.")
  end
end