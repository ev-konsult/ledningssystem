require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Testsvit för användarmodellen

  # Testfixtur
  def setup
    #@user = users(:two)
    @user = User.new(user_name: "TestUserHey", first_name: "TestUser", last_name: "UserTester",
                     email:"testuser@example.com", password:"foobar123", password_confirmation: "foobar123",
                     ssn: "123456-1233", phone_number: "0701234123")

    @user.create_contact_person(full_name: "MyName", email: "email@gmail.com", phone_number: "0721111111")
  end

  RISING = "Stigande"

  # Test av namn requirement
  test "usernamerequired" do
    @user.user_name = ""
    assert_not @user.valid?
  end

  test "firstnamenotrequired" do
    @user.first_name = ""
    assert @user.valid?
  end

  test "lastnamenotrequired" do
    @user.last_name = ""
    assert @user.valid?
  end

  test "usernamelength" do
    @user.user_name = "a" * 101
    assert_not @user.valid?
  end

  test "usernametooshort" do
    @user.user_name = "a" * 3
  end

  test "firstnamelength" do
    @user.first_name = "a" * 101
    assert_not @user.valid?
  end

  test "firstnametooshort" do
    @user.first_name = "a" * 3
  end

  test "lastnamelength" do
    @user.last_name = "a" * 101
    assert_not @user.valid?
  end

  test "lastnametooshort" do
    @user.last_name = "a" * 3
  end

  # Test av email requirement
  test "emailnotrequired" do
    @user.email = ""
    assert @user.valid?
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
  test "ssnnotrequired" do
    @user.ssn = ""
    assert @user.valid?
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
  test "phonenotrequired" do
    @user.phone_number = ""
    assert @user.valid?
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
    @user.password = "a" * 5
    @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "passwordtoolong" do
    @user.password = "a" * 101
    @user.password_confirmation = "a" * 101
    assert_not @user.valid?
  end

  test "password must match password confirmation" do
    @user.password = "a" * 7
    @user.password_confirmation = "b" * 7
    assert_not @user.valid?
  end

  test "valid password matching password confirmation makes user valid" do
    @user.password = "a" * 7
    @user.password_confirmation = "a" * 7
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

  # Testing the "sort" scope in the user model
  test "sorting users" do
    # Descending order (default)
    user_sorted_result = User.sort(:user_name)
    assert user_sorted_result.each_cons(2).all?{ |firstUser, secondUser| firstUser.user_name >= secondUser.user_name }

    user_sorted_result = User.sort(:first_name)
    assert user_sorted_result.each_cons(2).all?{ |firstUser, secondUser| firstUser.first_name >= secondUser.first_name }

    user_sorted_result = User.sort(:last_name)
    assert user_sorted_result.each_cons(2).all?{ |firstUser, secondUser| firstUser.last_name >= secondUser.last_name }

    user_sorted_result = User.sort(:email)
    assert user_sorted_result.each_cons(2).all?{ |firstUser, secondUser| firstUser.email >= secondUser.email }

    user_sorted_result = User.sort(:created_at)
    assert user_sorted_result.each_cons(2).all?{ |firstUser, secondUser| firstUser.created_at >= secondUser.created_at }
  end

  test "user role methods" do
    @user.role = roles(:admin)
    assert @user.admin?

    @user.role = roles(:editor)
    assert @user.editor?

    @user.role = roles(:project_manager)
    assert @user.project_manager?

    @user.role = roles(:human_resources_representative)
    assert @user.human_resources?
  end
end
