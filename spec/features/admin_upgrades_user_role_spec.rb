require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    @user = create(:user)    
    @admin = create(:user, :admin)
  end

  describe 'when I visit a user profile page' do

    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it 'displays an upgrade button' do

      visit user_path(@user)

      expect(page).to have_link("Upgrade to Merchant")

    end

    it 'updates the user role when I click the upgrade button' do

      visit user_path(@user)

      click_on "Upgrade"

      expect(current_path).to eq(merchant_path(@user))
      expect(page).to have_content("User has been upgraded to merchant.")

    end
  end

  describe 'next time the user logs in' do
    it 'should display a dashboard link' do
      visit login_path
      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password
      click_on "Log in"
      visit user_path(@user)
      click_on "Upgrade"
      click_on "Log Out"
      click_on "Log In"
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_on "Log in"

      expect(page).to have_link("Dashboard")

    end
  end
end