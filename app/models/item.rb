class Item < ApplicationRecord
    belongs_to :user
    has_many :order_items
    has_many :orders, through: :order_items
    validates_presence_of :name, :price, :inventory, :description
    validates_numericality_of :price, :greater_than => 0
    validates_numericality_of :inventory, :greater_than => 0

    def toggle_enabled
      update_attribute :enabled, !self.enabled
      self.enabled ? "enabled" : "disabled"
    end

    def merchant_name
      User.find(user_id).name
    end
end
