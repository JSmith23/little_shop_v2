require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    create_list(:user, 20)
    @user = User.first
    @admin = create(:user, :admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'when I visit users index and click on a user name' do
    it 'should display the user profile for that user' do

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
      
    end
  end
end