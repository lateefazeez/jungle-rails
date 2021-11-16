require 'rails_helper'

RSpec.feature "Visitors can click on Add button to add a product to the", type: :feature , js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
scenario "My Cart is updated when a product is added" do
  # ACT
  visit root_path
  find('.products article:first-child').click_on('Add')
  # DEBUG
  # VERIFY
  expect(page).to have_content 'My Cart (1)'
  save_screenshot
end
end