require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  def setup
    # Sätter current user till admin
    session[:user_id] = User.where(admin: true).take.id
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
end
