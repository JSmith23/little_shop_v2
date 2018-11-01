require "rails_helper"
describe "as any type of user" do
  describe "when I visit my cart" do
    def add_item(item, quantity)
      within(:css, "#item_#{item.id}") do
        quantity.times do
          click_button "Add to Cart"
        end
      end
    end

    def increment_item(item)
      within(:css, "#item_#{item.id}") do
        click_button "Increment Quantity"
      end
    end

    def decrement_item(item)
      within(:css, "#item_#{item.id}") do
        click_button "Decrement Quantity"
      end
    end

    def remove_item(item)
      within(:css, "#item_#{item.id}") do
        click_button "Remove Item"
      end
    end

    def check_item_displayed_on_page(item, quantity)
      expect(page).to have_content(item.name)
      expect(page).to have_xpath("//img[@src='#{item.thumbnail}']")
      expect(page).to have_content(item.user.name)
      expect(page).to have_content(item.price)
      expect(page).to have_content("Quantity: #{quantity}")
      expect(page).to have_content("Subtotal: #{quantity * item.price}")
    end

    def check_item_is_not_displayed_on_page(item)
      expect(page).not_to have_css("#item_#{item.id}")
    end

    def create_item(index, user)
      Item.create!(name:"Item_#{index}", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: index * rand(1..100), inventory: 1, description:"This is item #{index}", enabled: true, user_id: user.id)
    end

    it "displays all the information relating to items added to my cart" do
      user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")
      item_1 = Item.create!(name:"Item_1", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)
      item_2 = Item.create!(name:"Item_2", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)

      item_3 = Item.create!(name:"Item_3", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 1, description:"This is item 1", enabled: true, user_id: user.id)

      visit items_path

      add_item(item_1, 2)
      add_item(item_2, 3)
      add_item(item_3, 5)

      visit cart_path

      check_item_displayed_on_page(item_1, 2)
      check_item_displayed_on_page(item_2, 3)
      check_item_displayed_on_page(item_3, 5)
      expected_grand_total = item_1.price * 2 + item_2.price * 3 + item_3.price * 5
      expect(page).to have_content("Grand total: #{expected_grand_total}")

      click_button "Empty cart"
      expect(page).to have_content("Your cart is empty!")
    end

    it "displays all the information relating to items added to my cart" do
      user = User.create!(name: "Test Person", address: "123 lane", city: "Denver", state: "CO", zip: "80205", email: "test@test.com", password: "12345", password_confirmation: "12345")
      item_1 = Item.create!(name:"Item_1", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 5, description:"This is item 1", enabled: true, user_id: user.id)
      item_2 = Item.create!(name:"Item_2", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 5, description:"This is item 1", enabled: true, user_id: user.id)
      item_3 = Item.create!(name:"Item_3", thumbnail:"http://s7d9.scene7.com/is/image/JCPenney/DP0612201318104249C.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", price: 1, inventory: 5, description:"This is item 1", enabled: true, user_id: user.id)

      visit items_path

      add_item(item_1, 2)
      add_item(item_2, 3)
      add_item(item_3, 5)

      visit cart_path

      check_item_displayed_on_page(item_1, 2)
      check_item_displayed_on_page(item_2, 3)
      check_item_displayed_on_page(item_3, 5)

      expected_grand_total = item_1.price * 2 + item_2.price * 3 + item_3.price * 5
      expect(page).to have_content("Grand total: #{expected_grand_total}")

      remove_item(item_2)
      increment_item(item_1)
      decrement_item(item_3)

      check_item_is_not_displayed_on_page(item_2)
      check_item_displayed_on_page(item_1, 3)
      check_item_displayed_on_page(item_3, 4)

      expected_grand_total = item_1.price * 3 + item_3.price * 4
      expect(page).to have_content("Grand total: #{expected_grand_total}")

      3.times { decrement_item(item_1) }
      check_item_is_not_displayed_on_page(item_1)
      expected_grand_total = item_3.price * 4
      expect(page).to have_content("Grand total: #{expected_grand_total}")

      2.times { increment_item(item_3) }
      expect(page).to have_content("Exceeds merchant inventory")
      check_item_displayed_on_page(item_3, 5)

      expected_grand_total = item_3.price * 5
      expect(page).to have_content("Grand total: #{expected_grand_total}")
    end
  end
end
