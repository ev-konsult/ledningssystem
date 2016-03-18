require 'test_helper'

# Tests for users with different roles trying to
# access and manipulate different resources. The idea of this integration
# test is to make sure that the redirects work when you don't have access
# to a specific resource
class UserPrivilegesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:two)
    @article_params = { article: { id: 2, title: "Artikel skapad av admin", body: "Nån sorts artikel idk hej hej tjoho", user: @user } }
    @task_params    = { task:    { start: DateTime.new(2017, 4, 5),
                                   end: DateTime.new(2017, 5, 6),
                                   title: "Städa köket",
                                   description: "Efter kontorsfesten är köket väldigt smutsigt. Praktikanterna måste städa bort alla ölburkar och skrubba väggarna." },
                                  user_ids: [users(:one).id, users(:two)] }
  end

  def login_as_role(role)
    @user.role = role
    post_via_redirect "/login", session: { user_name: @user.user_name,
                                           password: "password" }
  end

  # Sequence of different roles trying to access users/index
  test "user privileges" do
    # User attempts access to users index. Should redirect to user
    login_as_role(roles(:user))
    get users_path
    assert_redirected_to @user

    # HR and Admin attempts to access user index. Should render user index
    login_as_role(roles(:human_resources_representative))
    get users_path
    assert_equal "/users", path

    login_as_role(roles(:admin))
    get users_path
    assert_equal "/users", path
  end

  # Sequence of different roles trying to access articles/new and creating
  # an article
  test "article privileges" do
    # User attempts to create article. Should redirect to user
    login_as_role(roles(:user))
    get new_article_path
    assert_redirected_to @user

    login_as_role(roles(:user))
    post "/articles", @article_params
    assert_redirected_to @user

    # Editor and admin attempts to create article.
    # Should render form and create article in both cases
    login_as_role(roles(:admin))
    get new_article_path
    assert_equal "/articles/new", path

    login_as_role(roles(:admin))
    post "/articles", @article_params
    assert_equal "/articles", path

    login_as_role(roles(:editor))
    get new_article_path
    assert_equal "/articles/new", path

    login_as_role(roles(:editor))
    post "/articles", @article_params
    assert_equal "/articles", path
  end

  # Sequence of different roles trying to access tasks/new and create
  # a task
  test "task privileges" do
    # User attempts to open form for creating task. Should redirect to user
    login_as_role(roles(:user))
    get new_task_path
    assert_redirected_to @user

    login_as_role(roles(:user))
    post "/tasks", @task_params
    assert_redirected_to @user

    # Editor and admin attempts to open form for creating task.
    # Should render form in both cases
    login_as_role(roles(:admin))
    get new_task_path
    assert_equal "/tasks/new", path

    login_as_role(roles(:admin))
    post "/tasks", @task_params
    assert_redirected_to @user

    login_as_role(roles(:editor))
    get new_task_path
    assert_equal "/tasks/new", path

    login_as_role(roles(:editor))
    post "/tasks", @task_params
    assert_redirected_to @user
  end
end
