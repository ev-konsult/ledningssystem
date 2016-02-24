require 'test_helper'

class AdminSearchUserTest < ActionDispatch::IntegrationTest
  # Testing a sequence of admin logging in and searching for a user
  test "admin searches for a user" do
    # Admin logs in
    https!
    get "/login"
    assert_response :success

    post_via_redirect "/login", session: { user_name: users(:one).user_name,
                                           password: "password" }

    assert_equal "/users/#{users(:one).id}", path

    # Admin searches for a user
    get "/users", { search: "user" }
    assert_response :success
    assert assigns(:users)

    # Result set should include last two users, but not the first
    assert assigns(:users).include?(users(:two))
    assert assigns(:users).include?(users(:three))
    assert_not assigns(:users).include?(users(:one))

    # Admin has too much beer and searches for something that doesn't exist
    get "/users", { search: "vbkeabeKLAEB;:,,,ebambmaekmbAEBPPPPPP" }
    assert_response :success
    assert assigns(:users).empty?
  end
end
