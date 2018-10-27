require 'rails_helper'

describe 'As an admin user' do

  before(:each) do
    create_list(:user, 20)
    @admin = create(:user, :admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end


  describe 'when I visit users path and click a disable button' do
    it 'should update the user status to disabled' do

      visit users_path

      expect(User.order(:name).first.enabled).to eq(true)
      click_on 'Disable', match: :first
      expect(User.order(:name).first.enabled).to eq(false)

    end
  end

  describe 'when I visit users path and click an enable button' do
    it 'should update the user status to enabled' do

      visit users_path

      # disable first user
      click_on 'Disable', match: :first
      expect(User.order(:name).first.enabled).to eq(false)

      # enable first user
      click_on 'Enable', match: :first
      expect(User.order(:name).first.enabled).to eq(true)

    end
  end

end