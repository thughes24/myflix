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
end