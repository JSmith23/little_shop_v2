require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    @admin = create(:user, :admin)
    @merchant = create(:user, :merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @address = "999 Last Street"
    @city = "Golden"
    @state = "CO"
    @zip = "80014"
  end

  describe 'when I visit the merchant dashboard page' do
    it 'should display the dashboard for given merchant' do

      visit merchant_path(@merchant)

      expect(page).to have_content("Merchant Dashboard for #{@merchant.name}")
      expect(page).to have_content("Edit Merchant Profile")

    end

    describe 'when I click the Edit Merchant Profile link' do
      it 'should display a form to update the merchant profile' do
        
        visit merchant_path(@merchant)

        click_on "Edit Merchant Profile"

        expect(current_path).to eq(edit_merchant_path(@merchant))
        expect(page).to have_content("Update Profile Information for #{@merchant.name}")

      end
    end

    describe 'when I edit any field and click the Update User button' do
      it 'should save my changes and display a the merchant dashboard' do
        
        visit merchant_path(@merchant)

        click_on "Edit Merchant Profile"

        fill_in "Address", with: @address
        fill_in "City", with: @city
        fill_in "State", with: @state
        fill_in "Zip", with: @zip

        click_on "Update User"

        expect(current_path).to eq(merchant_path(@merchant))
        expect(page).to have_content("Merchant Dashboard for #{@merchant.name}")

      end
    end
  end   
end
