# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FactoryGirl.define do
  factory :user, class: User do
    firstname     Faker::Name.first_name
    lastname      Faker::Name.last_name
    email         Faker::Internet.email
    password_digest Faker::Internet.password(8)
    admin         false
  end
end

FactoryGirl.create_list(:user, 25) 