require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:one)
  end

  test "should not be valid without start-date" do
    @task.start = ""
  end

  test "should not be valid without end-date" do
    @task.end = ""
  end

  test "should not be valid with start-date in the past" do
    @task.start = 3.days.ago
    assert_not @task.valid?
  end

  test "should not be valid with end-date before start-date" do
    @task.end = 3.days.ago
    assert_not @task.valid?
  end

end
