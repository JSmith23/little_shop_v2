require 'rails_helper'

describe 'As a registered user' do

  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'when I visit profile_path' do
    it 'should display all of my profile data except my password' do

      visit profile_path

      within("main.user-profile") do
        expect(page).to have_content("Welcome, #{@user.name}")
        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.address)
        expect(page).to have_content("#{@user.city}, #{@user.state} #{@user.zip}")
      end
    end

    it 'should display an edit profile button' do

      visit profile_path(@user)

      within("main.user-profile") do
        expect(page).to have_content("Edit Profile")
      end

      click_on "Edit Profile"

      within("main.update-user") do
        expect(current_path).to eq(profile_edit_path)
        expect(page).to have_content("Update Profile Information")
      end

    end
  end
end