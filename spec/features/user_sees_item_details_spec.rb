require 'rails_helper'

describe 'user can see items' do

  before(:each) do
    @user = create(:user)
    @merchant = create(:user, :merchant)
    @item = create(:item, user: @merchant)
  end

  describe 'user visits item page' do
    it 'sees all the details about item' do
        visit item_path(@item)
        expect(page).to have_content(@merchant.name)
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item.description)
        expect(page).to have_content(@item.inventory)
        expect(page).to have_content(@item.price)
    end
  end
end