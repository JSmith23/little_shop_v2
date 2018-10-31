require 'rails_helper'
 describe 'As a registered user I could not visit merchant dashboard page' do
    it 'could not visit dashboard page' do
        login(create(:user))
        visit '/dashboard'
        expect(current_path).to eq(root_path)
    end
end