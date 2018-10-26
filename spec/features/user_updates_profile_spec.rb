require 'rails_helper'

describe 'As a registered user, merchant, or admin' do

  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'when I visit my own profile page' do
    it 'should display a form to update my profile data' do

      visit profile_edit_path

      within("main.update-user") do
        expect(current_path).to eq(profile_edit_path)
        expect(page).to have_content("Update Profile Information")
      end

    end
  end

  describe 'when I visit my own profile page' do
    it 'should display a form to update my profile data' do

      visit profile_edit_path

      within("main.update-user") do
        expect(current_path).to eq(profile_edit_path)
        expect(page).to have_content("Update Profile Information")
      end

    end
  end

end