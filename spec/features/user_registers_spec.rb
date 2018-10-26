require 'rails_helper'

describe 'As an unregistered visitor' do
  describe 'when I visit the login page' do
    it 'should display a user registration form' do

      visit register_path

      within('main.user-registration-form') do

        expect(page).to have_content("New User Registration")

      end
    end
  end

  describe 'when I fill in all required fields' do
    it 'should display a user profile page' do

      visit register_path

      name = 'David Jones'
      address = '123 Main Street'
      city = 'Denver'
      state = 'CO'
      zip = '80014'
      email = 'davidjones@email.com'
      password = 'luckyguess1234'

      fill_in :user_name, with: name
      fill_in :user_address, with: address
      fill_in :user_city, with: city
      fill_in :user_state, with: state
      fill_in :user_zip, with: zip
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Create User'

      within("main.user-profile") do
        expect(page).to have_content("Welcome, #{name}")
      end

      within(".flash-container") do
        expect(page).to have_content("You have successfully registered and are now logged in.")
      end

    end
  end

  describe 'if I do not fill in all required fields' do
    it 'should not save the user information and return me to the registration form' do

      visit register_path

      name = 'David Jones'
      address = '123 Main Street'
      city = 'Denver'
      state = 'CO'
      email = 'davidjones@email.com'
      password = 'luckyguess1234'

      fill_in :user_name, with: name
      # fill_in :user_address, with: address
      fill_in :user_city, with: city
      fill_in :user_state, with: state
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Create User'

      within('main.user-registration-form') do
        expect(page).to have_content("New User Registration")
      end

      within(".flash-container") do
        expect(page).to have_content("Something went wrong. Please complete all required fields and try again.")
      end

    end
  end

  describe 'if I enter an email address already registered' do
    it 'should not save the user information and return me to the registration form' do

      user = create(:user)

      visit register_path

      name = 'David Jones'
      address = '123 Main Street'
      city = 'Denver'
      state = 'CO'
      zip = '80014'
      # Attempt to register with existing email
      email = user.email
      password = 'luckyguess1234'

      fill_in :user_name, with: name
      fill_in :user_address, with: address
      fill_in :user_city, with: city
      fill_in :user_state, with: state
      fill_in :user_zip, with: zip
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Create User'

      within('main.user-registration-form') do
        expect(page).to have_content("New User Registration")
      end

      within(".flash-container") do
        expect(page).to have_content("An account is already registered with that email address.")
      end

    end
  end

end