# Skapar admin med kontaktperson
@admin_contact = ContactPerson.create(full_name: Faker::Name.name, phone_number: Faker::PhoneNumber.phone_number, email: Faker::Internet.email)
@hr = Role.create(description: "Äger rättigheter till personal", role_name_id: :human_resources, can_edit_staff: true, can_show_person_details_verbose: true)
@manager = Role.create(description: "Äger rättigheter till att hantera uppgifter.", role_name_id: :project_manager, can_edit_tasks: true)
@editorz = Role.create(description: "Äger rättigheter till nyheter.", role_name_id: :editor, can_edit_news: true)
@admin_role = Role.create(description: "Äger rättigheter till hela systemet", role_name_id: :admin, can_edit_news: true, can_edit_tasks: true, can_edit_staff: true, can_edit_documents: true, can_show_person_details_verbose: true)
@role = Role.create(description: "Äger inga rättigheter", role_name_id: :user)

@admin = User.create(user_name: "Admin", first_name: "Lasse", last_name: "Karlsson",
            password: "adminpassword", password_confirmation: "adminpassword",
            email: "admin@gmail.com", ssn: "910506-1234", phone_number: "0701234123", contact_person: @admin_contact, role: @admin_role,
            contact_person: ContactPerson.create(full_name: Faker::Name.name, phone_number: Faker::PhoneNumber.phone_number,
                                                   email: "contact@gmail.com"))

@admin.educations << Education.create(graduation: DateTime.now, school: Faker::University.name, name: Faker::Commerce.department)

@editor = User.create(user_name: "Bosse", first_name: "Bo", last_name: "Larsson",
            password: "password", password_confirmation: "password",
            email: "editor@gmail.com", ssn: "910506-1337", phone_number: "0701234999", contact_person: @admin_contact, role: @editorz,
            contact_person: ContactPerson.create(full_name: Faker::Name.name, phone_number: Faker::PhoneNumber.phone_number,
                                                   email: "contact@gmail.com"))

@editor.educations << Education.create(graduation: DateTime.now, school: Faker::University.name, name: Faker::Commerce.department)

@hr_guy = User.create(user_name: "Toby", first_name: "Toby", last_name: "Flenderson",
            password: "password", password_confirmation: "password",
             email: "humanresources@gmail.com", ssn: "910506-1227", phone_number: "0701234919", contact_person: @admin_contact, role: @hr,
             contact_person: ContactPerson.create(full_name: Faker::Name.name, phone_number: Faker::PhoneNumber.phone_number,
                                                    email: "contact@gmail.com"))

@hr_guy.educations << Education.create(graduation: DateTime.now, school: Faker::University.name, name: Faker::Commerce.department)

@project_leader = User.create(user_name: "Michael", first_name: "Michael", last_name: "Scott",
            password: "password", password_confirmation: "password",
             email: "michael@gmail.com", ssn: "910506-1357", phone_number: "0701334999", contact_person: @admin_contact, role: @manager,
             contact_person: ContactPerson.create(full_name: Faker::Name.name, phone_number: Faker::PhoneNumber.phone_number,
                                                    email: "contact@gmail.com"))

@project_leader.educations << Education.create(graduation: DateTime.now, school: Faker::University.name, name: Faker::Commerce.department)

@normal_everyday_guy = User.create(user_name: "Nils", first_name: "Nils", last_name: "Mattsson",
            password: "password", password_confirmation: "password",
             email: "nils@gmail.com", ssn: "910506-1358", phone_number: "0701334999", contact_person: @admin_contact, role: @role,
             contact_person: ContactPerson.create(full_name: Faker::Name.name, phone_number: Faker::PhoneNumber.phone_number,
                                                    email: "contact@gmail.com"))

@normal_everyday_guy.educations << Education.create(graduation: DateTime.now, school: Faker::University.name, name: Faker::Commerce.department)

# Skapar användare med Faker, varje användare har en kontaktperson
99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  phone_number = Faker::PhoneNumber.phone_number
  ssn = "920616-925#{n}"
  password = "password"

  contact_first_name = Faker::Name.first_name
  contact_last_name = Faker::Name.last_name
  @contact_person = ContactPerson.create(full_name: "#{contact_first_name}, #{contact_last_name}", phone_number: Faker::PhoneNumber.phone_number,
                                         email: "#{contact_first_name}@gmail.com")

  @user = User.create(user_name: first_name, first_name: first_name, last_name: last_name,
              email: "#{first_name}@gmail.com", phone_number: phone_number, ssn: ssn, password: password, contact_person: @contact_person, role: @role)

  @user.educations << Education.create(graduation: DateTime.now, school: Faker::University.name, name: Faker::Commerce.department)
end

20.times do |n|
  # Random användare skapar artiklar
  User.offset(rand(User.count)).first.articles << Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
end

20.times do |n|
  @task = Task.create(title: Faker::Company.catch_phrase, description: "#{Faker::Company.catch_phrase}. #{Faker::Company.catch_phrase}. #{Faker::Company.catch_phrase}", start: DateTime.new(2018, 2, 3), end: DateTime.new(2018, 3, 4))
  # Sätt random användare till uppgiften
  4.times do |n|
    @task.users << User.offset(rand(User.count)).first
  end
end
