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

#Fake Manager
  5.times do |n|
    name  = Faker::Name.name
    email = "manager#{n+1}@example.com"
    password = "manager1"
    @manager = Manager.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 height: "100",
                 weight: "100",
                 date_of_birth: "2000/11/11",
                 description: "I am a fake manager."
                )

  #Fake Gym
  2.times do |i|
  name = "Gym#{n+10*i+1}"
  address = "Fake Street #{n+10*i+1}"
  @manager.gyms.create!(name: name,
                        address: address,
                        description: "Fake Gym.",
                        user_id: @manager.id
                        )
  end
end

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
               date_of_birth: "2001/12/12",
               description: "I am a fake user."
              )
end

#Fake Instructor
15.times do |n|
  name  = Faker::Name.name
  email = "instructor#{n+1}@example.com"
  password = "instructor1"
  Instructor.create!(name:  name,
                     email: email,
                     password:              password,
                     password_confirmation: password,
                     height: "100",
                     weight: "100",
                     date_of_birth: "2000/11/11",
                     description: "I am a fake instructor."
                    )
end

5.times do |n|
  name  = Faker::Name.name
  email = "student#{n+1}@example.com"
  password = "student1"
  Student.create!(name:  name,
                     email: email,
                     password:              password,
                     password_confirmation: password,
                     height: "100",
                     weight: "100",
                     date_of_birth: "2000/11/11",
                     description: "I am a fake Student."
                    )

end
