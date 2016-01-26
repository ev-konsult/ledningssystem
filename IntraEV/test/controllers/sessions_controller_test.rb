require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  include SessionsHelper

  # Funktionellt test av framgångsrik inloggning
  test "should successfully log in" do
    post :create, session: { name: "TestUser", password: "hello" }
    assert logged_in?
  end


  test "should nog log in with wrong password" do
    post :create, session: { name: "TestUser", password: "wrongpass" }
    assert_not logged_in?
  end
end
