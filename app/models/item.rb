class Item < ApplicationRecord
    belongs_to :user
    has_many :orders, through: :order_items
    has_many :order_items
    validates_presence_of :name, :thumbnail, :price, :inventory, :description
end
