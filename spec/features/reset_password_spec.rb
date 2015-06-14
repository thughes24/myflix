require 'spec_helper'

feature "Reset password integration" do
  scenario "user wants to reset forgotten password" do
    user = Fabricate(:user, email: 'example@example.com')
    visit '/'
    click_link("Sign In")
    click_link("Forgot Password?")
    fill_in "email", with: user.email
    expect(page).to have_selector("input[value='#{user.email}']")
    click_button("Send Email")
    open_email(user.email)
    current_email(user.email)
  end
end