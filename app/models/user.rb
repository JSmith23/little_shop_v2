class User < ApplicationRecord
  has_many :items
  has_many :orders
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :email,
                        :role

  validates_uniqueness_of :email

  enum role: %w(registered_user merchant admin)

  has_secure_password

  def toggle_enabled
    update_attribute :enabled, !self.enabled
    self.enabled ? "enabled" : "disabled"
  end

  def merchant_orders
    Order.joins(:items).where('items.user_id = ?', self.id).distinct
  end

  def upgrade_role
      update_attribute :role, 'merchant' if role == 'registered_user'
  end

  def downgrade_role
      update_attribute :role, 'registered_user' if role == 'merchant'
  end

end
