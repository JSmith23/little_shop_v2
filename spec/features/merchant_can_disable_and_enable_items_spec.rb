require 'rails_helper'

describe 'As a merchant user' do
  before(:each) do
    @merchant = create(:user, :merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    @item_1 = Item.create!( name: "Oval Link Chain Belt",	description: "Add something a little unexpected with this oval link chain belt that takes your look from casual to chic in an instant.", price:	36.26, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id)
  end

  it 'merchant sees disable/enable button under each of their items' do
    visit dashboard_items_path
    expect(page).to have_button("Disable")
  end

  it 'item is disabled when the disable button is clicked' do
    visit dashboard_items_path
    click_on "Disable"

    expect(page).to have_button("Enable")
    expect(page).to have_content("Disabled")
    expect(page).to have_content("This item is no longer for sale")
  end

  it 'item is enabled when the enable button is clicked' do
    visit dashboard_items_path

    click_on "Disable"

    expect(page).to have_button("Enable")
    expect(page).to have_content("Disabled")
    expect(page).to have_content("This item is no longer for sale")

    click_on "Enable"
    expect(page).to have_button("Disable")
    expect(page).to have_content("Enabled")
    expect(page).to have_content("This item is now for sale")
  end
end
