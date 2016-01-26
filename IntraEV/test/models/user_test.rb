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
end
