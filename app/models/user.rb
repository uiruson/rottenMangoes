class User < ActiveRecord::Base
has_many :reviews

has_secure_password

validates :email, presence: true
validates :firstname, presence: true, length: {minimum: 3}
validates :lastname, presence: true, length: {minimum: 3}
validates :password, length: {in: 6..20}, on: :create


def full_name
  "#{firstname} #{lastname}"
end

end
