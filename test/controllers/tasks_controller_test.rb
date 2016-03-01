require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  def setup
    # Sätter current user till admin


    @task = tasks(:one)
    @user = users(:two)

    session[:user_id] = users(:one)
  end

  test "index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "show" do
    get(:show, { 'id' => tasks(:one).id })
    assert_response :success
    assert_not_nil assigns(:task)
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, task: { start: DateTime.new(2017, 4, 5),
                            end: DateTime.new(2017, 5, 6),
                            title: "Städa köket",
                            description: "Efter kontorsfesten är köket väldigt smutsigt. Praktikanterna måste städa bort alla ölburkar och skrubba väggarna." },
                    user_ids: [users(:one).id, users(:two)]
    end

    assert_redirected_to task_path(assigns(:task))
  end

  test "should edit task" do
    # Same title
    title = "Städa köket"

    # New description
    description = "Nu måste praktikanterna skrubba taket också"

    patch :update, id: @task, task: { title: title, description: description,
                                      start: DateTime.new(2017, 4, 5),
                                      end: DateTime.new(2017, 5, 6) },
                              user_ids: [users(:one).id, users(:two)]
    assert_equal "Uppgiften uppdaterades!", flash[:success]
    assert_redirected_to @task

    @task.reload
    assert_equal title, @task.title
    assert_equal description, @task.description
  end

  # Tests that you can't add a user to a task via an update, when the
  # user is already assigned to the task
  test "should not add duplicate users to task" do
    @task.users << @user

    assert_no_difference('@task.users.count') do
      patch :update, id: @task, task: { title: "Lorem ipsum lorem ipsum",
                                        description: "Lorem ipsum lorem ipsum lorem ipsum",
                                        start: DateTime.new(2017, 4, 5),
                                        end: DateTime.new(2017, 5, 6) },
                                user_ids: [@user.id]
    end
  end
end
