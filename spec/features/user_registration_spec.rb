require 'spec_helper'

feature "User registers a new account", js: true, vcr: true do
  background { visit new_user_path }
  scenario "with valid personal info and invalid card info" do
    user_details
    card_details_section("2132")
    click_button("Register Account")
    expect(page).to have_content("This card number looks invalid.")
  end
  scenario "with valid personal info and valid card info" do
    user_details
    card_details_section("4242424242424242")
    click_button("Register Account")
    expect(page).to have_content("Forgot")
  end
  scenario "with valid personal info and declined card" do
    user_details
    card_details_section("4000000000000002")
    click_button("Register Account")
    expect(page).to have_content("Your card was declined")
  end
  scenario "with invalid personal info and valid card" do
    user_details(false)
    card_details_section("4242424242424242")
    click_button("Register Account")
    expect(page).to have_content("Please enter valid personal details")
  end

  def card_details_section(card_number)
    fill_in "credit-card", with: card_number
    fill_in "security-code", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
  end

  def user_details(valid=true)
    fill_in "Username", with: valid == false ? nil : "joeybadass"
    fill_in "Email", with: valid == false ? nil : "joeybadass@gmail.com"
    fill_in "Password", with: valid == false ? nil : "password"
  end
end