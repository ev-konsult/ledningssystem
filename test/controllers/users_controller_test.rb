require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include SessionsHelper

  # Testfixture
  def setup
    @user = users(:two)
    @admin = users(:one)
    # "Logs" admin in
    session[:user_id] = @admin.id
  end

  # Functional test for creating a user
  test "create user" do
    # Asserts that a user can be added
    assert_difference('User.count') do
      post :create, user: { id: 4,
                            user_name: "foobar",
                            first_name: "foobar",
                            last_name: "foobar",
                            password: "foobar",
                            password_confirmation: "foobar",
                            phone_number: "1891189118",
                            ssn: "910506-1891",
                            email: Faker::Internet.email,
                            role_id: roles(:user).id,
                            contact_person_attributes: { full_name: 'foobar', email: "foobar@gmail.com",
                                                         phone_number: "0721111111"}}
    end

    # Tests the redirect
    assert_redirected_to user_path(User.find(4))
  end

  # Verifying that the different roles have the correct authentications
  test "user gets different rights" do
    @user.role = roles(:admin)
    assert @user.role.can_edit_news
    assert @user.role.can_edit_staff
    assert @user.role.can_edit_tasks
    assert @user.role.can_edit_documents
    assert @user.role.can_show_person_details_verbose

    @user.role = roles(:user)
    assert_not @user.role.can_edit_news
    assert_not @user.role.can_edit_staff
    assert_not @user.role.can_edit_tasks
    assert_not @user.role.can_edit_documents
    assert_not @user.role.can_show_person_details_verbose

    @user.role = roles(:editor)
    assert @user.role.can_edit_news
    assert_not @user.role.can_edit_staff
    assert_not @user.role.can_edit_tasks
    assert_not @user.role.can_edit_documents
    assert_not @user.role.can_show_person_details_verbose

    @user.role = roles(:project_manager)
    assert_not @user.role.can_edit_news
    assert_not @user.role.can_edit_staff
    assert @user.role.can_edit_tasks
    assert_not @user.role.can_edit_documents
    assert_not @user.role.can_show_person_details_verbose

    @user.role = roles(:human_resources_representative)
    assert_not @user.role.can_edit_news
    assert @user.role.can_edit_staff
    assert_not @user.role.can_edit_tasks
    assert_not @user.role.can_edit_documents
    assert @user.role.can_show_person_details_verbose
  end

  test "non admins should not be able to create users" do
    session[:user_id] = @user.id

    assert_no_difference('User.count', 1) do
      post :create, user: { name: 'foobar',
                            password: "foobar",
                            password_confirmation: "foobar" }
    end

    assert_redirected_to @user
  end

  test "destroy user" do
    assert_difference('User.count', - 1) do
      delete :destroy, id: @user.id
    end

    assert_equal "Du gav personen sparken, bra jobbat!", flash[:success]
  end

  test "non admins should not be able to destroy users" do
    session[:user_id] = @user.id

    assert_no_difference('User.count') do
      delete :destroy, id: @user.id
    end

    assert_redirected_to @user
  end

  # Tests that users can be listed in users/index.html.erb
  test "admin page should list users" do
    @user.authenticate("hello")
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
end
