require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  include SessionsHelper

  def setup
    @user = users(:two)
  end

  # Funktionellt test av framgångsrik inloggning
  test "should successfully log in" do
    post :create, session: { name: "TestUser", password: "hello" }
    assert logged_in?
  end


  test "should nog log in with wrong password" do
    post :create, session: { name: "TestUser", password: "wrongpass" }
    assert_not logged_in?
  end

  # Funktionellt test av inloggning med "kom ihåg mig" iklickat
  test "log in with remember me" do
    post :create, session: { name: @user.name, password: "hello", remember_me: 1 }

    # Kollar att cookien är där..
    assert_not_nil cookies['remember_token']
  end

  # Funktionellt test av inloggning med "kom ihåg mig" inte iklickat
  test "log in without remember me" do
    post :create, session: { name: @user.name, password: "hello", remember_me: 0 }

    # Kollar att cookien inte är där..
    assert_nil cookies['remember_token']
  end
end
