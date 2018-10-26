require 'rails_helper'

describe 'As a merchant user' do
  describe 'when I visit the dashboard path' do
    it 'should display a merchant dashboard' do

      visit dashboard_path

      within("main.dashboard") do
        expect(page).to have_content("Merchant Dashboard")
      end
    end
  end
end