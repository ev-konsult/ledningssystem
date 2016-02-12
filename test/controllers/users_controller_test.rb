require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include SessionsHelper

  # Testfixtur
  def setup
    # Sätter current user till admin
    session[:user_id] = User.where(admin: true).take.id

    # Hämtar testanvändaren ur users.yml
    @user = users(:two)
  end

  # Funktionellt test för skapande av användare
  test "create user" do
    # Testar att användare läggs till
    assert_difference('User.count') do
      post :create, user: { user_name: "foobar",
                            first_name: "foobar",
                            last_name: "foobar",
                            password: "foobar",
                            password_confirmation: "foobar",
                            phone_number: "1891189118",
                            ssn: "910506-1891",
                            email: Faker::Internet.email,
                            contact_person_attributes: { full_name: 'foobar', email: "foobar@gmail.com",
                                                         phone_number: "0721111111"}}
    end

    # Testar redirect
    assert_redirected_to current_user

    # Testar flashmeddelandet
    assert_equal "Du har registrerat en ny anställd!", flash[:success]
  end

  # Testar att icke-admins inte kan skapa användare
  test "non admins should not be able to create users" do
    # Sätter current user till en vanlig användare
    @user = User.where(admin: false).take
    session[:user_id] = @user.id

    # Testar att användare _INTE_ läggs till
    assert_no_difference('User.count', 1) do
      post :create, user: { name: 'foobar',
                            password: "foobar",
                            password_confirmation: "foobar" }
    end

    assert_redirected_to @user
  end

  # Funktionellt test för att ta bort användare
  test "destroy user" do
    # Testar att användare tas bort
    assert_difference('User.count', - 1) do
      delete :destroy, id: @user.id
    end

    # Testar flashmeddelandet
    assert_equal "Du gav personen sparken, bra jobbat!", flash[:success]
  end

  # Testar att icke-admins inte kan ta bort användare
  test "non admins should not be able to destroy users" do
    # Sätter current user till en vanlig användare
    @user = User.where(admin: false).take
    session[:user_id] = @user.id

    # Testar att användare _INTE_ tas bort
    assert_no_difference('User.count') do
      delete :destroy, id: @user.id
    end

    assert_redirected_to @user
  end

  # Testar att användare listas på adminsidan (users/index),
  # när admin är inloggad
  test "admin page should list users" do
    @user.authenticate("hello")
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
end
