require 'spec_helper'

feature "Admin Views Payments" do
  background do
    user = Fabricate(:user, username: "poop", password: "poop", customer_token: "123")
    Payment.create(user: user, reference_id: "refid", amount: "999")
  end
  scenario "admin is able to view payments" do
    admin = Fabricate(:user, password: "cats", admin: true)
    visit "/sign-in"
    fill_in "Username", with: admin.username
    fill_in "Password", with: "cats"
    click_button('Log In')
    visit admin_payments_path
    expect(page).to have_content("poop")
  end
  scenario "user is not able to view payments" do
    visit "/sign-in"
    fill_in "Username", with: "poop"
    fill_in "Password", with: "poop"
    click_button('Log In')
    visit admin_payments_path
    expect(page).not_to have_content("999")
  end
end