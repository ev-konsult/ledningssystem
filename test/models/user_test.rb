require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Testsvit för användarmodellen

  # Testfixtur
  def setup
    @user = User.new(name: 'Exempel', password: "foobar", password_confirmation: 'foobar')
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
  test "email wrong format" do
    @user.email = "valid@gmail.com"
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
