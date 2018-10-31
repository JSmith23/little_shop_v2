require 'rails_helper'

describe 'As a merchant user' do

  before(:each) do
    @merchant = create(:user, :merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    @item_1 = Item.create( name: "Oval Link Chain Belt",	description: "Add something a little unexpected with this oval link chain belt that takes your look from casual to chic in an instant.", price:	36.26, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
    @item_2 = Item.create( name: "Liz Claiborne® Tipped Tank Top - Petite",	description: "Beat the heat in our crepe tank top with contrast tipping for extra sizzle.  roundneck gently rounded hem polyester washable imported", price:	43.51, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP1220201417021434M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
    @item_3 = Item.create( name: "St. John’s Bay® Inlet Mens Canvas Boat Shoes",	description: "Casual in canvas, these preppy slip-on boat shoes are ideal for laid-back living.   cotton canvas upper slip on with lace-up detail contrast stitching canvas lining textile/rubber sole", price: 48.34, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP1215201417013852M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
    @name = "Stickers"
    @description = "They stick to things."
    @price = 2
    @inventory = 100
    @thumbnail = "http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2"
    @default_thumbnail = "https://www.riobeauty.co.uk/images/product_image_not_found_thumb.gif"
  end

  describe 'when I visit the items index and click Add an Item' do
    it 'should display a new item form' do

      visit items_path
      click_on "Add an Item"

      expect(current_path).to eq(new_item_path)
  
    end
  end

  describe 'when I complete the form and click Create Item' do
    it 'should display the items index and a message stating that item was added' do

      visit items_path
      click_on "Add an Item"

      fill_in "Name", with: @name
      fill_in "Description", with: @description
      fill_in "Price", with: @price
      fill_in "Inventory", with: @inventory
      fill_in "Thumbnail", with: @thumbnail

      click_on "Create Item"

      expect(current_path).to eq(items_path)
      expect(page).to have_content(@name)
      expect(page).to have_xpath("//img[contains(@src, '#{@thumbnail}')]")
    end
  
    it 'should not require a thumbnail url' do

      visit items_path
      click_on "Add an Item"

      fill_in "Name", with: @name
      fill_in "Description", with: @description
      fill_in "Price", with: @price
      fill_in "Inventory", with: @inventory

      click_on "Create Item"

      expect(current_path).to eq(items_path)
      expect(page).to have_content(@name)
      expect(page).to have_xpath("//img[contains(@src, '#{@default_thumbnail}')]")

    end

    it 'should not accept 0 or less for price or inventory' do

      visit items_path
      click_on "Add an Item"

      fill_in "Name", with: @name
      fill_in "Description", with: @description
      fill_in "Price", with: 0
      fill_in "Inventory", with: 0

      click_on "Create Item"

			expect(page).to have_content("Price and inventory must be greater than 0. Please try again.")

    end

    it 'should not accept blank name' do

      visit items_path
      click_on "Add an Item"

      fill_in "Name", with: ''
      fill_in "Description", with: @description
      fill_in "Price", with: 2
      fill_in "Inventory", with: 3

      click_on "Create Item"

			expect(page).to have_content("Something went wrong. Please complete all required fields and try again.")

    end
  end


end