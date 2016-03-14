require 'test_helper'

class AdminAssignsTaskTest < ActionDispatch::IntegrationTest
  # Testing this sequence:
  # Admin logs in -> creates task with assigned users ->  changes assigned users
  # -> marks task as completed

  TASK_CREATED = "Uppgiften skapades!"

  test "admin creates task, assigns users to it and marks it as complete" do
    # Admin logs in
    https!
    get "/login"
    assert_response :success

    post_via_redirect "/login", session: { user_name: users(:one).user_name,
                                           password: "password" }

    assert_equal "/users/#{users(:one).id}", path

    # Admin adds a task
    get "/tasks/new"
    assert_response :success
    id = 980190963

    post_via_redirect "/tasks", task: { id: id,
                                        start: DateTime.new(2017, 4, 5),
                                        end: DateTime.new(2017, 5, 6),
                                        title: "Städa köket",
                                        description: "Efter kontorsfesten är köket väldigt smutsigt. Praktikanterna måste städa bort alla ölburkar och skrubba väggarna." },
                                user_ids: [users(:one).id, users(:two).id]
    assert_equal "/tasks/#{id}", path
    assert_equal TASK_CREATED, flash[:success]

    # Admin views the created article
    get "/tasks/#{id}"
    assert_response :success

    # Admin changes assigned users
    patch_via_redirect "/tasks/#{id}", task: { description: "Efter kontorsfesten är köket väldigt smutsigt. Praktikanterna måste städa bort alla ölburkar och skrubba väggarna." },
                                       user_ids: [users(:three).id]

    assert_equal TASK_CREATED, flash[:success]

    # Admin marks it as complete
    patch_via_redirect "/tasks/#{id}", task: { status: :done },
                                       user_ids: [users(:three).id]

    assert_equal TASK_CREATED, flash[:success]
  end
end
