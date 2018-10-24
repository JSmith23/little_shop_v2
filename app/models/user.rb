class User < ApplicationRecord

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :email,
                        :password,
                        :role,
                        :enabled
  
  validates_uniqueness_of :email
  validates_confirmation_of :password

  enum role: %w(registered_user admin merchant)

  has_secure_password

end