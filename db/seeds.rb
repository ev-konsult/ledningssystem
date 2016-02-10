# Skapar admin med kontaktperson
@admin_contact = ContactPerson.create(full_name: "Admins Contact Guy", phone_number: "0722222222", email: "admin@gmail.com")
User.create(name: "Admin", password: "adminpassword", password_confirmation: "adminpassword", admin: true,
            email: "admin@admin.com", ssn: "123456-1234", phone_number: "0701234123", contact_person: @admin_contact)

# Skapar användare med Faker
99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  phone_number = Faker::PhoneNumber.phone_number
  ssn = "920616-925#{n}"
  password = "password"

  @contact_person = ContactPerson.create(full_name: Faker::Name.name, phone_number: Faker::PhoneNumber.phone_number, email: Faker::Internet.email)
  User.create(name: name, email: email, phone_number: phone_number, ssn: ssn, password: password, contact_person: @contact_person)
end

# Skapar artiklar
User.find(1).articles << Article.create(title: "Hejsan hoppsan", body: "Jag gillar katter dom är mycket söta. Hejdå")
User.find(2).articles << Article.create(title: "Lorem Ipsum", body: "Hej hej hejsan hejsan hej hej hejsan hejsan")
