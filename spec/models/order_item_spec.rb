require 'rails_helper'

describe OrderItem, type: :model do

  describe 'Relationships' do
    it { should belong_to :order}
    it { should belong_to :item}
  end

  describe 'Methods' do
    it 'should update the fulfilled attribute' do
      @merchant = create(:user, :merchant)
      @order = Order.create( status: 'pending' )
      @item = @merchant.items.create( name: 'Candy', 
                          description: 'Sweet', 
                          price: 1, 
                          inventory: 100 )
      @order_item = @item.order_items.create( order_id: @order.id,
                                              quantity: 5,
                                              price: 1 )
      @order_item.fulfill

      expect(@order_item.fulfilled).to eq(true)
    end
  end

end