require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include SessionsHelper

  # Funktionellt test för skapande av användare
  test "create user" do
    # Sätter current user till admin
    session[:user_id] = User.where(admin: true).take

    # Testar att användare läggs till
    assert_difference('User.count') do
      post :create, user: { name: 'foobar',
                            password: "foobar",
                            password_confirmation: "foobar" }
    end

    # Testar redirect
    assert_redirected_to current_user

    # Testar flashmeddelandet
    assert_equal "Du har registrerat en ny användare!", flash[:success]
  end

  # Testar att icke-admins inte kan skapa användare
  test "non admins should not be able to create users" do
    # Sätter current user till en vanlig användare
    session[:user_id] = User.where(admin: false).take

    # Testar att användare _INTE_ läggs till
    assert_no_difference('User.count') do
      post :create, user: { name: 'foobar',
                            password: "foobar",
                            password_confirmation: "foobar" }
    end
  end
end
