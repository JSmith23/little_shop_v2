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
                        :role,
                        :enabled

  validates_uniqueness_of :email
  validates_confirmation_of :password


  enum role: %w(registered_user admin merchant)

  has_secure_password

end
