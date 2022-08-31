# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "user1"
email = "user1@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user2"
email = "user2@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user3"
email = "user3@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user4"
email = "user4@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user5"
email = "user5@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user6"
email = "user6@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user7"
email = "user7@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user8"
email = "user8@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user9"
email = "use9@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

name = "user10"
email = "user10@mail.com"
password = "password"
password_confirmation = "password"
User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation
                    )

10.times do |n|
    name = "task1"
    detail = "task1"
    deadline = Time.parse("2025/01/01")
    status= "未着手"
    priority= 0
    user_id= 3
    Task.create!(name: name,
                        detail: detail,
                        deadline: deadline,
                        status: status,
                        priority: priority,
                        user_id: user_id
                        )
end


title = "ラベルA"
Label.create!(title: title)

title = "ラベルB"
Label.create!(title: title)

title = "ラベルC"
Label.create!(title: title)

title = "ラベルD"
Label.create!(title: title)

title = "ラベルE"
Label.create!(title: title)

title = "ラベルF"
Label.create!(title: title)

title = "ラベルG"
Label.create!(title: title)

title = "ラベルH"
Label.create!(title: title)

title = "ラベルI"
Label.create!(title: title)

title = "ラベルJ"
Label.create!(title: title)
