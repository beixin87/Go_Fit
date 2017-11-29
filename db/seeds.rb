# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Admin",
             email: "admin@example.com",
             password:              "admin1",
             password_confirmation: "admin1",
             height: "99",
             weight: "99",
<<<<<<< HEAD
             date_of_birth: "2005/12/12",
=======
             date_of_birth: "05/12/12",
>>>>>>> e7629e842362b2a3c50fe57c5ff68ca01c3f3242
             description: "I am Admin.",
             admin: true)

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
