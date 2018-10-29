require "rails_helper"

describe "As a user" do

  before(:each) do
    @user = create(:user)
    @item_1 = @user.items.create!(name:"Item_1", thumbnail:"http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true )
    @item_2 = @user.items.create!(name:"Item_2", thumbnail:"http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", price: 2, inventory: 2, description:"This is item 2", enabled: false )
  end

  describe "when I visit the items index page" do
    it "user sees items basic attributes" do
      visit items_path

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.id)
      expect(page).to have_content(@item_1.price)
      expect(page).to have_content(@item_1.inventory)
      expect(page).to_not have_content(@item_2.name)
    end
  end

  describe "when I click the name of an item" do
    it "displays the item show page" do
      visit items_path

      click_on @item_1.name

      expect(current_path).to eq(item_path(@item_1))
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@item_1.inventory)
      expect(page).to have_content(@item_1.price)

    end
  end
end
