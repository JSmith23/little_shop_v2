require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    @admin = create(:user, :admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'when I visit the dashboard path' do
    it 'should display an admin dashboard' do

      visit dashboard_path

      expect(page).to have_content("Welcome Administrator")
      
    end
  end
end