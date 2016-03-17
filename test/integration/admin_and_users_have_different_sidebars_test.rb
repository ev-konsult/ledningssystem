require 'test_helper'

class AdminAndUsersHaveDifferentSidebarsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:one)
    @user = users(:two)
  end

  test "admin sidebar should be different from user sidebar" do
    # Log in as admin
    post_via_redirect "/login", session: { user_name: @admin.user_name,
                                           password: "password" }

    # Check that the menu structure is correct for users
    assert_select "ul.nav.menu"

    assert_select "span.glyphicon.glyphicon-user"
    assert_select "span.glyphicon.glyphicon-star"
    assert_select "span.glyphicon.glyphicon-tasks"
    assert_select "span.glyphicon.glyphicon-signal"

    # Log in as user
    post_via_redirect "/login", session: { user_name: @user.user_name,
                                           password: "password" }

    # Check that the menu structure is correct for admins
    assert_select "ul.nav.menu"

    assert_select "span.glyphicon.glyphicon-star"
    assert_select "span.glyphicon.glyphicon-road"
    assert_select "span.glyphicon.glyphicon-signal"
    assert_select "span.glyphicon.glyphicon-signal"
    assert_select "span.glyphicon.glyphicon-book"
    assert_select "span.glyphicon.glyphicon-heart"
    assert_select "span.glyphicon.glyphicon-tree-conifer"

    assert_select "span.glyphicon.glyphicon-folder-open"
    assert_select "span.glyphicon.glyphicon-folder-open"
    assert_select "span.glyphicon.glyphicon-folder-open"
  end
end
