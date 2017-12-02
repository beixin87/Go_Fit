# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Admin
User.create!(name:  "Admin",
             email: "admin@example.com",
             password:  "admin1",
             password_confirmation: "admin1",
             height: "99",
             weight: "99",
             date_of_birth: "2005/12/12",
             description: "I am Admin.",
             admin: true)
#Manager
Manager.create!(name: "Manager",
                email: "manager@example.com",
                password: "manager1",
                password_confirmation: "manager1",
                height: "99",
                weight: "99",
                date_of_birth: "2000/11/11",
                description: "I am Manager")

#Fake users
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               height: "99",
               weight: "99",
               description: "I am a fake user."
              )
end
