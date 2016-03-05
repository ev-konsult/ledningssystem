require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:one)
  end

  test "should not be valid without start-date" do
    @task.start = Date.new
    # ^ We can't use nil or empty for this, becasue it will give an error
    # when validating "end_date_cannot_be_before_start_date". Can't compare
    # nil with DateTime. Date.new gives the start of unix time stamp instead
    assert_not @task.valid?
  end

  test "should not be valid without title" do
    @task.title = ""
    assert_not @task.valid?
  end

  test "should not be valid with too short title" do
    @task.title = "a" * 3
    assert_not @task.valid?
  end

  test "should not be valid with too long title" do
    @task.title = "no" * 256
    assert_not @task.valid?
  end

  test "should not be valid without description" do
    @task.description = ""
    assert_not @task.valid?
  end

  test "should not be valid with too short description" do
    @task.description = "a" * 19
    assert_not @task.valid?
  end

  test "should not be valid without end-date" do
    @task.end = nil
    assert_not @task.valid?
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
