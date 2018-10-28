require "rails_helper"

# As any kind of user on the system
# When I visit my cart ("/cart")

#  I see all items I've added to my cart
#  And I see a link to empty my cart
#  Each item in my cart shows the following information:
# the name of the item
# a small thumbnail image of the item
# the merchant I'm buying this item from
# the price of the item
# my desired quantity of the item
# a subtotal (price multiplied by quantity)
#  I also see a grand total of what everything in my cart will cost

describe "as any type of user" do 
    describe "when I visit my cart" do 
        it "displays all the information relating to items added to my cart" do 
            user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")
            item_1 = Item.create!(name:"Item_1", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)
            # item_2 = Item.create!(name:"Item_2", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)
            # item_3 = Item.create!(name:"Item_3", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)

            visit items_path 

            click_button "Add Item"
            save_and_open_page
            expect(page).to have_content(item_1.name)
            expect(page).to have_xpath("//img[@src='#{item_1.thumbnail}']")
            expect(page).to have_content(item_1.user.name)
            expect(page).to have_content(item_1.price)

            
            # expect(page).to have_content(item_2.name)
            # expect(page).to have_content(item_3.name)
            # expect(page).to have content(item_2.price)
            # expect(page).to have content(item_3.description)

        end 
    end 
end 