require 'test_helper'

class EducationTest < ActiveSupport::TestCase


  def setup
   @education = Education.new(name: "TestEduName", school: "Linneus", graduation: "2013-06-08")
  end

  # Test av namn requirement
  test "namerequired" do
    @education.name = ""
    assert_not @education.valid?
  end

  # Test av namnlängd
  test "namelength" do
    @education.name = "a" * 101
    assert_not @education.valid?
  end

  # Test av school requirement
  test "schoolrequired" do
    @education.school = ""
    assert_not @education.valid?
  end

  # Test av skollängd
  test "schoollength" do
    @education.school = "123"
    assert_not @education.valid?
  end

end
