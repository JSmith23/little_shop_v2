require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    @merchant = create(:user, :merchant)
    @admin = create(:user, :admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @item = @merchant.items.create( name: "Oval Link Chain Belt",	description: "Add something a little unexpected with this oval link chain belt that takes your look from casual to chic in an instant.", price:	36.26, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100 )
  end

  describe 'when I click Edit Item from merchant items' do
    it 'should display an edit item form' do

      visit merchant_items_path(@merchant)

      click_on "Edit Item"

      expect(current_path).to eq(edit_item_path(@item))
      
    end
  end

  describe 'when I update a field and click submit' do
    it 'should save the item and redirect to the dashboard items path' do

      visit merchant_items_path(@merchant)

      click_on "Edit Item"

      fill_in "Inventory", with: 200

      click_on "Update Item"

      expect(current_path).to eq(merchant_items_path(@merchant))
      expect(page).to have_content("Inventory: 200")
      
    end
  end
end