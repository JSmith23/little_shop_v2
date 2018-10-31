require 'rails_helper'

describe 'As an admin user' do
  before(:each) do
    @merchants = create_list(:user, 10, :merchant)    
    @admin = create(:user, :admin)
  end

  def disable_merchant(merchant)
    within(:css, "#merchant_#{merchant.id}") do
      click_button "Disable"
    end
  end

  it 'non admin user cannot access merchants page' do
    login(create(:user))
    expect(page).not_to have_content('Merchants')
  end

  it 'non admin user cannot access merchants page' do
    login(@admin)
    expect(page).to have_content('Merchants')
  end
  
  describe 'when I visit mechant index and click on a disable button' do
    it 'should display that merchant is disabled and he cannot log in to system' do
      merchant_to_disable = @merchants.sample
      
      login(merchant_to_disable)
      expect(page).not_to have_content("Email or password is invalid")
      logout
      
      login(@admin)
      visit merchants_path   
      disable_merchant(merchant_to_disable)
      expect(page).to have_content("Merchant '#{merchant_to_disable.name}' is disabled!")
      logout
      
      login(merchant_to_disable)
      expect(page).to have_content("Email or password is invalid")
    end
  end
end