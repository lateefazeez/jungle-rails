require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  # SETUP
  before :each do
      @user = User.create!(
        first_name:  "Bob",
        last_name: "Blob",
        email: "blob@gmail.com",
        password: "heyo",
        password_confirmation: "heyo"
      )
  end
scenario "Login Test" do
  # ACT
  visit root_path
  find('.login_signup:first-child').click_on('Login')
  fill_in 'email', with: "blob@gmail.com"
  fill_in 'password', with: "heyo"
  find('.btn').click

  # VERIFY
  expect(page).to have_content 'Logout'
  save_screenshot
end
end