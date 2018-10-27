require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    create_list(:user, 20)
    @admin = create(:user, :admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'when I visit the users path' do
    it 'should display a list of all users' do

      visit users_path

      within("main.users-index") do
        expect(page).to have_content("All Users")
        expect(page).to have_content(User.first.name)
        expect(page).to have_content(User.last.name)
      end

    end

    it 'should display a button next to each name to enable or disable the user' do

      # Create a disabled user, rest are enabled by default
      User.create( name: "Ben Winch", address: "123 Main Street", city: "Denver", state: "CO", zip: '80014', email: "benwinch@email.com", password: "BWinch123", password_confirmation: "BWinch123", role: 0, enabled: false)

      visit users_path

      within("main.users-index") do
        expect(page).to have_selector("input[type=submit][value='Disable']")
        expect(page).to have_selector("input[type=submit][value='Enable']")
      end

    end
  end

  describe 'when I click on a user name' do
    it 'should display the user show page' do

      visit users_path

      click_on User.first.name

      expect(current_path).to eq(user_path(User.first))
      expect(page).to have_content("Profile data for #{User.first.name}")
      expect(page).to have_content(User.first.name)

    end
  end
end