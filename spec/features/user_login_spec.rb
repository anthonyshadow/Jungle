require 'rails_helper'

RSpec.feature "User can log in sucessfuly and is taken to the homepage", type: :feature, js: true do

  before :each do
    @user = User.create!(first_name: "first name", last_name:"last name", email: "email@email.com", password: "password", password_confirmation:"password")
  end

  scenario "User logs in and is redeircted to the home page" do

    visit "/login"
    fill_in 'email', with: 'email@email.com'
    fill_in 'password', with: 'password'

    click_on("Submit")

    expect(page).to have_content("Signed in as first name")

    save_screenshot

  end
end