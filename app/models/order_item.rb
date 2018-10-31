class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def self.merchant_order_items(order_id, merchant_id)
    joins(:items).where('items.user_id = #{user}, orders.id = #{order_id}')
  end

end
