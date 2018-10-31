require 'rails_helper'

describe 'as a current user' do

  it 'I can cancel order' do
    @user = create(:user)
    order_1 = @user.orders.create!(id: 1, status: "pending")

    visit login_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_on 'Log in'

    click_on 'User Orders'


  within(:css, "#order#{order_1.id}") do
    click_on "Cancel Order"
  end

    expect(page).to have_content("Order #{order_1.id}")
    expect(page).to have_content('cancelled')
  end
end
