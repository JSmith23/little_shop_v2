require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    @merchant = create(:user, :merchant)    
    @admin = create(:user, :admin)
  end

  describe 'when I visit a merchant dashboard page' do

    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it 'displays an downgrade button' do

      visit merchant_path(@merchant)

      expect(page).to have_link("Downgrade to Registered User")

    end

    it 'updates the user role when I click the downgrade button' do

      visit merchant_path(@merchant)

      click_on "Downgrade"

      expect(current_path).to eq(user_path(@merchant))
      expect(page).to have_content("Merchant has been downgraded to registered user.")

    end
  end

  describe 'next time the user logs in' do
    it 'should display a dashboard link' do
      visit login_path
      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password
      click_on "Log in"
      visit merchant_path(@merchant)
      click_on "Downgrade"
      click_on "Log Out"
      click_on "Log In"
      fill_in "Email", with: @merchant.email
      fill_in "Password", with: @merchant.password
      click_on "Log in"

      expect(page).to_not have_link("Dashboard")

    end
  end

end