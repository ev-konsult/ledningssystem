# Skapar admin med kontaktperson
@admin_contact = ContactPerson.create(full_name: "Admins Contact Guy", phone_number: "0722222222", email: "admin@gmail.com")
User.create(user_name: "Admin", first_name: "Admin", last_name: "Adminsson",
            password: "adminpassword", password_confirmation: "adminpassword", admin: true,
            email: "admin@admin.com", ssn: "123456-1234", phone_number: "0701234123", contact_person: @admin_contact)

User.create(user_name: "TestUser", first_name: "Test", last_name: "User",
            password: "testuserpassword", password_confirmation: "testuserpassword",
            admin: false, email: "test@user.com", ssn: "123456-1337", phone_number: "0701234999", contact_person: @admin_contact)

# Skapar användare med Faker, varje användare har en kontaktperson
99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  phone_number = Faker::PhoneNumber.phone_number
  ssn = "920616-925#{n}"
  password = "password"

  @contact_person = ContactPerson.create(full_name: Faker::Name.name, phone_number: Faker::PhoneNumber.phone_number,
                                         email: Faker::Internet.email)

  User.create(user_name: Faker::Name.name, first_name: first_name, last_name: last_name,
              email: email, phone_number: phone_number, ssn: ssn, password: password, contact_person: @contact_person)
end

# Skapar artiklar för första och sista användaren
User.first.articles << Article.create(title: "Hejsan hoppsan", body: "Jag gillar katter dom är mycket söta. Hejdå")
User.last.articles << Article.create(title: "Lorem Ipsum", body: "Hej hej hejsan hejsan hej hej hejsan hejsan")

Task.create(title: "Städa köket", description: "Efter kontorsfesten är köket väldigt smutsigt. Praktikanterna måste städa bort alla ölburkar och skrubba väggarna.", start: DateTime.new(2017, 2, 3), end: DateTime.new(2017, 3, 4))

Task.create(title: "Fixa bokföringen", description: "Det är för mycket siffror i bokföringen. Ersätt några med emojis.", start: DateTime.new(2017, 4, 5), end: DateTime.new(2017, 5, 6))
