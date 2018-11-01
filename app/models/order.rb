class Order < ApplicationRecord
  validates_presence_of :status
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  def total_quantity
    order_items.sum(:quantity)
  end

  def total_price
    order_items.sum(:price)
  end

  def cancel
    update_attribute :status, "cancelled"
  end

  def self.merchant_orders(user)
   joins(:items).where("items.user_id = #{user}").uniq
  end

  def items_for_merchant(merchant_id)
    items.where(user_id: merchant_id)
  end

  def update_status
    order_items.each do |order_item|
      return "Order status is pending." if !order_item.fulfilled
    end
    update_attribute :status, "complete"
    return "Order status updated to complete."
  end

end
