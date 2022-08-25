# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "user1"
email = "user1@mail.com"
password = "password1"
password_confirmation = "password1"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password_confirmation
             )

name = "user2"
email = "user2@mail.com"
password = "password2"
password_confirmation = "password2"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password_confirmation
             )
