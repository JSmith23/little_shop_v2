require "rails_helper"

describe "user sees items" do 
    it "user sees items basic attributes" do 
        user = create(:user)
        item_1 = Item.create!(name:"Item_1", thumbnail:"whatever", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)
        item_2 = Item.create!(name:"Item_2", thumbnail:"whatever", price: 2, inventory: 2, description:"This is item 2", enabled: false, user_id: user.id)

        visit items_path
        
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_1.thumbnail)
        expect(page).to_not have_content(item_2.name)
        
    end 
end 