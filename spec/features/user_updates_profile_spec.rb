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
      # password = "#{user}"

      fill_in :user_address, with: address
      fill_in :user_city, with: city
      fill_in :user_zip, with: zip
      # fill_in :user_password, with: password
      # fill_in :user_password_confirmation, with: password

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

  describe 'if I enter an email address that is already used' do
    it 'should not save the changes and display a message that the email is already in use' do

      @user_2 = User.create(name: "David Jones",
                            address: "456 First Avenue",
                            city: "Boulder",
                            state: "CO",
                            zip: "80001",
                            email: "davidjones@email.com",
                            password: "test1234",
                            password_confirmation: "test1234")

      visit profile_edit_path

      # Enter an existing email address
      fill_in :user_email, with: @user_2.email

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


end
