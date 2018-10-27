require 'rails_helper'
describe 'user sees order information' do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'user sees all orders on order index for user' do
    user = create(:user)
    order_1 = Order.create!(id: 1, status: "pending", user_id: user.id)
    order_2 = Order.create!(id: 2, status: "fulfilled", user_id: user.id)

    visit user_orders_path(user)

    expect(page).to have_content(order_1.status)
    expect(page).to have_content(order_2.status)
  end
end
