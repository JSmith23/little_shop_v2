class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def fulfill
    update_attribute :fulfilled, true
  end
end
