class User < ApplicationRecord
  has_many :items
  has_many :orders
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :email,
                        :password,
                        :role
  validates_uniqueness_of :email
  # validates_confirmation_of :password


  enum role: %w(registered_user merchant admin)


  has_secure_password

  def toggle_enabled
    self.enabled = !self.enabled
  end

  def merchant_orders
    Order.joins(:items).where('items.user_id = ?', self.id)
  end

end
