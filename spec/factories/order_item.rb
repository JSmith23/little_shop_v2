FactoryBot.define do
  factory :order_item do
    sequence(:item_quantity)    { |n| n }
    sequence(:item_price)       { |n| n * 1 }
    order
    item
  end
end
