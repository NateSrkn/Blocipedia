# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.all


5.times do
    User.create!(
        email: Faker::Internet.email,
        password: Faker::Internet.password,
    )
end

20.times do
    Wiki.create!(
        title: Faker::Name.name,
        body: Faker::Seinfeld.quote,
        private: false,
        user: users.sample,
    )
end

admin = User.create!(
    email: 'NateSrkn@gmail.com',
    password: 'password',
    role: 2
)

standard = User.create!(
    email: 'Standard@gmail.com',
    password: 'password'
)

premium = User.create!(
    email: 'premium@ex.com',
    password: 'password',
    role: 1
)

Wiki.create!(
    title: 'Private Wiki',
    body: 'Private Body',
    private: true,
    user: User.last
)

puts "Seed finished"
puts "#{User.count} user(s) created"
puts "#{Wiki.count} Wiki(s) created"