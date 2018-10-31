require "rails_helper"

describe "user sees items" do
  it "user sees items basic attributes" do
    user = create(:user)
    merchant = create(:user, :merchant)
    item_1 = Item.create!(name:"Item_1", thumbnail:"http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: merchant.id)
    item_2 = Item.create!(name:"Item_2", thumbnail:"http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", price: 2, inventory: 2, description:"This is item 2", enabled: false, user_id: merchant.id)

    visit items_path

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.id)
    expect(page).to have_content(item_1.price)
    expect(page).to have_content(item_1.inventory)
    expect(page).to have_content(merchant.name)
    expect(page).to_not have_content(item_2.name)

  end
end
