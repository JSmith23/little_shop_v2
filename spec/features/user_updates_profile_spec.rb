require 'rails_helper'

describe 'As a registered user, merchant, or admin' do

  before(:each) do
    @user = create(:user)
  end

  describe 'when I visit my own profile edit page' do
    it 'should display a form to update my profile data' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_edit_path

      within("main.update-user") do
        expect(current_path).to eq(profile_edit_path)
        expect(page).to have_content("Update Profile Information")
      end

    end
  end

  describe 'when I change any or all information and click submit' do
    it 'should display my profile page with the updated information' do

      user = create(:user)

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_on "Log in"
      
      click_on "Edit Profile"

      address = "456 First Avenue"
      city = "Boulder"
      zip = "80301"

      fill_in :user_address, with: address
      fill_in :user_city, with: city
      fill_in :user_zip, with: zip

      click_on 'Update User'

      within("main.user-profile") do
        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Welcome, #{user.name}")
        expect(page).to have_content(address)
        expect(page).to have_content(city)
        expect(page).to have_content(zip)
      end

      within(".flash-container") do
        expect(page).to have_content("Your profile has been updated.")
      end
    end
  end

  describe 'if I enter an email address that is already used' do
    it 'should not save the changes and display a message that the email is already in use' do


      user = create(:user)

      user_2 = User.create(name: "David Jones", 
                            address: "456 First Avenue",
                            city: "Boulder",
                            state: "CO",
                            zip: "80001",
                            email: "davidjones@email.com",
                            password: "test1234",
                            password_confirmation: "test1234")

      
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_on "Log in"
      
      click_on "Edit Profile"

      # Enter an existing email address
      fill_in :user_email, with: user_2.email
      
      click_on 'Update User'
      
      within("main.update-user") do
        expect(current_path).to eq(profile_edit_path)
        expect(page).to have_content("Update Profile Information")
      end

      within(".flash-container") do
        expect(page).to have_content("An account is already registered with that email address.")
      end
    end
  end

  describe 'if I delete any required fields' do
    it 'does not save and I see a message to fill in all required fields' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_edit_path

      fill_in :user_address, with: ""

      click_on 'Update User'

      within("main.update-user") do
        expect(current_path).to eq(profile_edit_path)
        expect(page).to have_content("Update Profile Information")
      end

      within(".flash-container") do
        expect(page).to have_content("Update failed. Please ensure all required fields are filled in and try again.")
      end

    end
  end

end
