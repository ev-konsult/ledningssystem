require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  # Test fixture - simulates logging in as admin
  def setup
    session[:user_id] = users(:one).id
  end

  test "show statistics" do
    # Makes sure we get an ok response
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)

    # Checks HTML for the charts
    assert_select "div#chart-1"
    assert_select "div#chart-2"
    assert_select "div#chart-3"
    assert_select "div#chart-4"
  end
end
