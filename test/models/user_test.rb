require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Testsvit för användarmodellen

  # Testfixtur
  def setup
    #@user = users(:two)
    @user = User.new(name: "TestUserHey", email:"testuser@example.com", password:"foobar123", password_confirmation: "foobar123",
                     ssn: "123456-1233", phone_number: "0701234123")

    @user.create_contact_person(full_name: "MyName", email: "email@gmail.com", phone_number: "0721111111")                 
  end

  # Test av namn requirement
  test "namerequired" do
    @user.name = ""
    assert_not @user.valid?
  end

  # Test av namnlängd
  test "namelength" do
    @user.name = "detta borde vara mer än hundra tecken,
                  vilket alldeles för långt namn för den här applikationen!
                  wow, alldeles för många tecken. Går inte att registrera sig"
    assert_not @user.valid?
  end

  # Test av email requirement
  test "emailrequired" do
    @user.email = ""
    assert_not @user.valid?
  end

  # Test av email fel format
  test "email wrong format" do
    @user.email = "nah.com"
    assert_not @user.valid?
  end

  # Test av email rätt format
  test "email right format" do
    @user.email = "validasdasdasdasd@gmail.com"
    assert @user.valid?
  end

  # Test av ssn requirement
  test "ssnrequired" do
    @user.ssn = ""
    assert_not @user.valid?
  end

  # Test av ssn fel format
  test "ssn wrong format" do
    @user.ssn = "nah"
    assert_not @user.valid?
  end

  # Test av ssn rätt format
  test "ssn right format" do
    @user.ssn = "910506-5974"
    assert @user.valid?
  end

  # Test av tomt telefonnummer
  test "phonerequired" do
    @user.phone_number = ""
    assert_not @user.valid?
  end

  # Test av rätt formaterat telefonnummer
  test "phone right format" do
    @user.phone_number = "0769426341"
    assert @user.valid?
  end

  # Test av fel formaterat telefonnummer
  test "phone wrong format" do
    @user.phone_number = "1891"
    assert_not @user.valid?
  end

  # Testar att namn måste vara unika
  test "duplicatedename" do
    lookALike = @user.dup
    @user.save
    assert_not lookALike.valid?
  end

  # Testar att minimumlängden för lösenord fungerar
  test "minimumpassword" do
    @user.password = "kek"
    @user.password_confirmation = "kek"
    assert_not @user.valid?
  end

  # Testar att lösenordet verkligen hashas med bcrypt när användaren sparas
  test "should hash password with bcrypt" do
    @user.save

    #BCrypt har $2a som identifierare
    algorithm_identifier = @user.password_digest[0, 3]
    assert algorithm_identifier == "$2a"
  end

  # Testar sökningen via scope
  test "search should filter result" do
    # Det finns två användare i testfixturen (users.yml) som har "test" i namnet
    user_search_result = User.search("Test")
    assert user_search_result.count == 2

    # Det finns inga användare med "Nope" i namnet. Ska returnera tom AR-relation
    user_search_result = User.search("Nope")
    assert user_search_result.empty?
  end
end
