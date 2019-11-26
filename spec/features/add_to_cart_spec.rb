require 'rails_helper'

RSpec.feature "Vistors can click the add to cart button from the homepage and the cart number will increase", type: :feature, js: true do

  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel1.jpg"),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "they click on add to cart and the cart number increases " do
  # ACT
  visit root_path

  # VERIFY
  click_on("Add", match: :first)

  expect(page).to have_content("My Cart (1)")

  # DEBUG
  save_screenshot
  end

end