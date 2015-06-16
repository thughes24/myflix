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
    current_email.click_link("Reset Password")
    fill_in "password", with: "hellohi"
    click_button("Reset Password")
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'hellohi'
    click_button('Log In')
    expect(page).to have_content(user.username)
    expect(User.first.reset_token).to be_blank
  end
end