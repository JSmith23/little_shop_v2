require 'rails_helper'
describe 'user sees order information' do
  it 'user sees all orders on order index for user' do
    user = User.create!(id:1, name:"Bob", address:"1234 Turing Street", city:"Denver", state:"CO", email:"bob@turingschool.com", password:"1234cantguessthis", role:1, enabled:true )
    order_1 = Order.create!(id: 1, status: "pending", user_id: 1)
    order_2 = Order.create!(id: 2, status: "fulfilled", user_id: 1)

    visit user_orders_path(user)

    expect(page).to have_content(order_1.status)
    expect(page).to have_content(order_2.status)
  end
end
