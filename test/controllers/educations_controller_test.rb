require 'test_helper'

class EducationsControllerTest < ActionController::TestCase
  def setup
    @user = users(:two)
    @valid_education = { name: "Webbprogrammerare",
                         school: "Linnéuniversitetet",
                         graduation: DateTime.new(2017, 4, 5) }

    @invalid_education = { name: "",
                           school: "",
                           graduation: "" }
  end

  test "valid education is created on user" do
    assert @user.educations.empty?

    assert_difference("@user.educations.count") do
      @user.educations.create(@valid_education)
    end
  end

  test "invalid educations is not created on user" do
    assert @user.educations.empty?

    assert_no_difference("@user.educations.count") do
      @user.educations.create(@invalid_education)
    end
  end
end
