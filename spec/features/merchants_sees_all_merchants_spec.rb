require 'rails_helper'

# TODO: checkout the same comment in registered user spec
# spec/features/user_sees_all_merchants_spec.rb
describe 'Merchant list page' do

  before(:each) do
    @user_1, @user_2, @user_3 = create_list(:user, 3)
    @merchant_1, @merchant_2, @merchant_3 = create_list(:user, 3, :merchant)
    @admin = create(:user, :admin)
  end

  describe 'when I visit the merchants path' do
    it 'should display all merchants as an admin user' do
      login(@admin)
      visit merchants_path

      expect(current_path).to eq(merchants_path)

      within('main.users-index') do
        expect(page).to have_content("All Merchants")
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)
        expect(page).to_not have_content(@user_1.name)
        expect(page).to_not have_content(@user_2.name)
        expect(page).to_not have_content(@user_3.name)
      end
    end

    it 'should NOT be able to visit page as a merchant user' do
      login(@merchant_1)
      visit merchants_path

      expect(page).to have_content("You are not authorized to view the requested page.")
    end

    it 'should NOT be able to visit page as a registered user' do
      login(@user_1)
      visit merchants_path

      expect(page).to have_content("You are not authorized to view the requested page.")
    end
  end
end