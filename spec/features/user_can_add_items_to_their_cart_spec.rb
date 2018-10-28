require 'rails_helper'

describe "When a user adds items to their cart" do
  it "a message is displayed" do
    user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")
    item = Item.create!(name:"Item_1", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)

    
    visit items_path

    click_button "Add Item"

    expect(page).to have_content("You now have 1 #{item.name}.")
  end

  it "the message correctly increments for multiple songs" do

    user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")
    item = Item.create!(name:"Item_1", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)
    
    visit items_path

    click_button "Add Item"

    expect(page).to have_content("You now have 1 #{item.name}.")

    click_button "Add Item"

    expect(page).to have_content("You now have 2 #{item.name}.")
  end
end