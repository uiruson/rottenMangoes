class User < ActiveRecord::Base

has_secure_password

validates :email, presence: true
validates :firstname, presence: true, length: {minimum: 4}
validates :lastname, presence: true, length: {minimum: 4}
validates :password, length: {in: 6..20}, on: :create

end
