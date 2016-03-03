# Skapar admin med kontaktperson
@admin_contact = ContactPerson.create(full_name: "Admins Contact Guy", phone_number: "0722222222", email: "admin@gmail.com")
@hr = Role.create(description: "Äger rättigheter till personal", role_name: "Personalansvarig", can_edit_staff: true, can_show_person_details_verbose: true)
@manager = Role.create(description: "Äger rättigheter till att hantera uppgifter.", role_name: "Projektledare", can_edit_tasks: true)
@editorz = Role.create(description: "Äger rättigheter till nyheter.", role_name: "Redaktör", can_edit_news: true)
@admin_role = Role.create(description: "Äger rättigheter till hela systemet", role_name: "Admin", can_edit_news: true, can_edit_tasks: true, can_edit_staff: true, can_edit_documents: true, can_show_person_details_verbose: true)

User.create(user_name: "Admin", first_name: "Admin", last_name: "Adminsson",
            password: "adminpassword", password_confirmation: "adminpassword",
            email: "admin@admin.com", ssn: "123456-1234", phone_number: "0701234123", contact_person: @admin_contact, role: @admin_role)

@editor = User.create(user_name: "TestUser", first_name: "Test", last_name: "User",
            password: "testuserpassword", password_confirmation: "testuserpassword",
            email: "test@user.com", ssn: "123456-1337", phone_number: "0701234999", contact_person: @admin_contact, role: @editorz)

@hr_guy = User.create(user_name: "HumanResources", first_name: "Toby", last_name: "Flenderson",
            password: "testuserpassword", password_confirmation: "testuserpassword",
             email: "hrtest@user.com", ssn: "113456-1337", phone_number: "0701234919", contact_person: @admin_contact, role: @hr)

@project_leader = User.create(user_name: "ProjectLeader", first_name: "Michael", last_name: "Scott",
            password: "testuserpassword", password_confirmation: "testuserpassword",
             email: "mc@user.com", ssn: "123426-1337", phone_number: "0701334999", contact_person: @admin_contact, role: @manager)

@role = Role.create(description: "Äger inga rättigheter", role_name: "Användare")

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
              email: email, phone_number: phone_number, ssn: ssn, password: password, contact_person: @contact_person, role: @role)
end

# Skapar artiklar för första och sista användaren
User.first.articles << Article.create(title: "Hejsan hoppsan", body: "Jag gillar katter dom är mycket söta. Hejdå")
User.last.articles << Article.create(title: "Lorem Ipsum", body: "Hej hej hejsan hejsan hej hej hejsan hejsan")

Task.create(title: "Städa köket", description: "Efter kontorsfesten är köket väldigt smutsigt. Praktikanterna måste städa bort alla ölburkar och skrubba väggarna.", start: DateTime.new(2017, 2, 3), end: DateTime.new(2017, 3, 4))

Task.create(title: "Fixa bokföringen", description: "Det är för mycket siffror i bokföringen. Ersätt några med emojis.", start: DateTime.new(2017, 4, 5), end: DateTime.new(2017, 5, 6))
