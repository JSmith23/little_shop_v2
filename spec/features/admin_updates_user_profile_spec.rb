require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    create_list(:user, 20)
    @user = User.first
    @admin = create(:user, :admin)
    @address = "999 First Street"
    @city = "Boulder"
    @state = "CO"
    @zip = "80014"

  end

  describe 'when I visit users index and click on a user name' do
    it 'should display the user profile for that user' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit users_path

      click_on @user.name

      within("main.user-profile") do
        expect(page).to have_content("Profile data for #{@user.name}")
        expect(page).to have_content(@user.name)
      end
      
    end
  end

  describe 'when I visit users profile and click Edit Profile' do
    it 'should display the edit profile page for that user' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit users_path

      click_on @user.name
      click_on "Edit Profile"

      within("main.update-user") do
        expect(page).to have_content("Update Profile Information for #{@user.name}")
      end

      
    end
  end

  describe 'when I submit changes to a user profile' do
    it 'should display the user profile page for that user' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit users_path

      click_on @user.name
      click_on "Edit Profile"

      fill_in "Address", with: @address
      fill_in "City", with: @city
      fill_in "State", with: @state
      fill_in "Zip", with: @zip

      click_on "Update User"

      within(".flash-container") do
        expect(page).to have_content("Profile for #{@user.name} has been updated.")
      end

      within("main.user-profile") do
        expect(page).to have_content("Profile data for #{@user.name}")
        expect(page).to have_content(@address)
        expect(page).to have_content(@city)
        expect(page).to have_content(@state)
        expect(page).to have_content(@zip)
      end

    end
  end

  describe 'when I click Edit Profile from my own profile' do
    it 'should update my own profile information' do

      visit login_path

      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password

      click_on "Log in"
      
      click_on "Edit Profile"

      fill_in "Address", with: @address
      fill_in "City", with: @city
      fill_in "State", with: @state
      fill_in "Zip", with: @zip

      click_on "Update User"
      
      within(".flash-container") do
        expect(page).to have_content("Your profile has been updated.")
      end

      within("main.user-profile") do
        expect(page).to have_content("Profile data for #{@admin.name}")
        expect(page).to have_content(@address)
        expect(page).to have_content(@city)
        expect(page).to have_content(@state)
        expect(page).to have_content(@zip)
      end


    end
  end
end