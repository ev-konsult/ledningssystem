User.create(name: "Admin", password: "adminpassword", password_confirmation: "adminpassword", admin: true)

99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  phone_number = Faker::PhoneNumber.phone_number
  ssn = "123456789"
  password = "password"

  User.create(name: name, email: email, phone_number: phone_number, ssn: ssn, password: password)
end


User.first.articles << Article.create(title: "Hejsan hoppsan", body: "Jag gillar katter dom är mycket söta. Hejdå")
User.find(2).articles << Article.create(title: "Lorem Ipsum", body: "Hej hej hejsan hejsan hej hej hejsan hejsan")

