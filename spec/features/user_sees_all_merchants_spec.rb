require 'rails_helper'

describe 'As a registered user' do

  before(:each) do
    @user_1, @user_2, @user_3 = create_list(:user, 3)
    @merchant_1, @merchant_2, @merchant_3 = create_list(:user, 3, :merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
  end

  describe 'when I visit the merchants path' do
    it 'should display all merchants' do

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

    it 'should NOT display enable/disable buttons for each merchant' do

      visit merchants_path

      within("main.users-index") do
        expect(page).to_not have_selector("input[type=submit][value='Disable']")
        expect(page).to_not have_selector("input[type=submit][value='Enable']")
      end

    end
  end
end