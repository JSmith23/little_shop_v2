require 'rails_helper'

describe 'As a registered user, merchant, or admin' do

  before(:each) do
    @user = create(:user)
  end

  describe 'when I visit my own profile page' do
    it 'should display a form to update my profile data' do

      visit edit_profile_path(@user)

      within("main.update-user") do
        expect(current_path).to eq(edit_profile_path(@user))
        expect(page).to have_content("Update Profile Information")
      end

    end
  end

  describe 'when I visit my own profile page' do
    it 'should display a form to update my profile data' do

      visit edit_profile_path(@user)

      within("main.update-user") do
        expect(current_path).to eq(edit_profile_path(@user))
        expect(page).to have_content("Update Profile Information")
      end

    end
  end

end