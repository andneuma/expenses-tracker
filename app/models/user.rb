class User < ActiveRecord::Base
  ROLES = %w[Unapproved User Admin]
  
  has_secure_password
  has_many :expenses

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, :length => { :minimum => 5}
end
