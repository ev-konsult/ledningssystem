# Skapar admin
User.create(name: "Admin", password: "adminpassword", password_confirmation: "adminpassword", admin: true,
            email: "admin@admin.com", ssn: "123456-1234", phone_number: "0701234123")

# Skapar användare med Faker
99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  phone_number = Faker::PhoneNumber.phone_number
  ssn = "920616-925#{n}"
  password = "password"

  @user = User.create(name: name, email: email, phone_number: phone_number, ssn: ssn, password: password)
end

# Skapar artiklar
User.first.articles << Article.create(title: "Hejsan hoppsan", body: "Jag gillar katter dom är mycket söta. Hejdå")
User.last.articles << Article.create(title: "Lorem Ipsum", body: "Hej hej hejsan hejsan hej hej hejsan hejsan")

# Skapar en kontaktperson för varje användare (med Faker)
User.all.each do |user|
  name = Faker::Name.name
  email = Faker::Internet.email
  phone_number = Faker::PhoneNumber.phone_number

  user.create_contact_person(full_name: name, email: email, phone_number: phone_number)
end
