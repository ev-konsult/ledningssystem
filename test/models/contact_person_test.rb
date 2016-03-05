require 'test_helper'

class ContactPersonTest < ActiveSupport::TestCase

  def setup
    @contact_person = ContactPerson.new(full_name: "TestUserHey", email:"testuser@example.com", phone_number: "0701234123")
  end

  # Test av email requirement
  test "emailnotrequired" do
    @contact_person.email = ""
    assert @contact_person.valid?
  end

  # Test av email fel format
  test "email wrong format" do
    @contact_person.email = "nah.com"
    assert_not @contact_person.valid?
  end

  # Test av email rätt format
  test "email right format" do
    @contact_person.email = "validasdasdasdasd@gmail.com"
    assert @contact_person.valid?
  end

  # Test av namn requirement
  test "namenotrequired" do
    @contact_person.full_name = ""
    assert @contact_person.valid?
  end

  # Test av namnlängd
  test "namelength" do
    @contact_person.full_name = "a" * 101
    assert_not @contact_person.valid?
  end

  # Test av tomt telefonnummer
  test "phonenotrequired" do
    @contact_person.phone_number = ""
    assert @contact_person.valid?
  end

  # Test av rätt formaterat telefonnummer
  test "phone right format" do
    @contact_person.phone_number = "0769426341"
    assert @contact_person.valid?
  end

  # Test av fel formaterat telefonnummer
  test "phone wrong format" do
    @contact_person.phone_number = "1891"
    assert_not @contact_person.valid?
  end

end
