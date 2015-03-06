namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(first_name: "Example User",
                 last_name: "Example User",
                 email: "example@railstutorial.org",
                 birthdate: "1990-05-11",
                 password: "foobar",
                 password_confirmation: "foobar")
    49.times do |n|
      first_name  = Faker::Name.first_name
      last_name  = Faker::Name.last_name
      birthdate = Date.today - Faker::Number.number(3).to_i.days
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(first_name: first_name,
                   last_name: last_name,
                   birthdate: birthdate,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end