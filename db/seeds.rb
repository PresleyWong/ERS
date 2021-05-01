# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# if Rails.env.production? 
#   State.create(state: "California", state_abbr: "CA")
#   State.create(state: "North Dakota", state_abbr: "ND")
# end

# if Rails.env.development?
#   for 1..25
#     Orders.create(order_num: Faker::Number:number(8), order_date: Faker::Business.credit_card_expiry_date)
#   end
# end

User.create(
    eng_name: Faker::Name.first_name,
    chn_name: Faker::Name.last_name,
    gender: ["Brother", "Sister"].sample ,
    language: "English",
    locality: "Petaling Jaya",
    email: "test1@gmail.com",
    password: "123456",
    admin: true,
    phone_no: Faker::Number.number(digits: 10)
)

User.create(
    eng_name: Faker::Name.first_name,
    chn_name: Faker::Name.last_name,
    gender: ["Brother", "Sister"].sample ,
    language: "English",
    locality: "Petaling Jaya",
    email: "test2@gmail.com",
    password: "123456",
    phone_no: Faker::Number.number(digits: 10)
)


20.times do |n|
    User.create(
            eng_name: Faker::Name.first_name,
            chn_name: Faker::Name.last_name,
            gender: ["Brother", "Sister"].sample ,
            language: "English",
            locality: "Petaling Jaya",
            email: Faker::Internet.email,
            password: "123456",
            phone_no: Faker::Number.number(digits: 10)
        )
        
    Event.create(
        title: Faker::Mountain.name,
        date: Faker::Date.forward(days: 23),
        start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        end_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        meeting_id1: Faker::Number.number(digits: 10),
        attachment_url1: Faker::LoremFlickr.image
    )
end


60.times do |n|
    suppress(Exception) do
        Appointment.create(
            user_id: Faker::Number.between(from: 1, to: 20), 
            event_id: Faker::Number.between(from: 1, to: 20),
            language: "English",
            join_url: Faker::LoremFlickr.image
        )
    end     
end