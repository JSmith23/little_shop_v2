require 'rails_helper'

describe 'As a registered user, merchant, or admin' do

  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'when I visit my own profile edit page' do
    it 'should display a form to update my profile data' do

      visit profile_edit_path

      within("main.update-user") do
        expect(current_path).to eq(profile_edit_path)
        expect(page).to have_content("Update Profile Information")
      end

    end
  end

  describe 'when I change any or all information and click submit' do
    it 'should display my profile page with the updated information' do

      visit profile_edit_path

      address = "456 First Avenue"
      city = "Boulder"
      zip = "80301"
      password = "BWinch123"

      fill_in :user_address, with: address
      fill_in :user_city, with: city
      fill_in :user_zip, with: zip

      click_on 'Update User'

      within("main.user-profile") do
        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Welcome, #{@user.name}")
        expect(page).to have_content(address)
        expect(page).to have_content(city)
        expect(page).to have_content(zip)
      end

      within(".flash-container") do
        expect(page).to have_content("Your profile has been updated.")
      end
    end
  end

  describe 'if I do not change any information and click submit' do
    it 'should display the edit profile page with a message that no changes were submitted' do

      visit profile_edit_path

      # no changes made to any fields

      click_on 'Update User'

      save_and_open_page

      within("main.update-user") do
        expect(current_path).to eq(profile_edit_path)
        expect(page).to have_content("Update Profile Information")
      end

      within(".flash-container") do
        expect(page).to have_content("No changes submitted.")
      end
    end
  end


end