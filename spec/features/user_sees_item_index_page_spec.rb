require "rails_helper"

describe "user sees items" do 
    it "user sees items basic attributes" do 
        user = User.create!(id:1, name:"Bob", address:"1234 Turing Street", city:"Denver", state:"CO", email:"bob@turingschool.com", password:"1234cantguessthis", role:1, enabled:true )
        item_1 = Item.create!(name:"Item_1", thumbnail:"whatever", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id:1)
        item_2 = Item.create!(name:"Item_2", thumbnail:"whatever", price: 2, inventory: 2, description:"This is item 2", enabled: false, user_id:1)

        visit items_path
        
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_1.thumbnail)
        expect(page).to_not have_content(item_2.name)
        
    end 
end 