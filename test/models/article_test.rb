require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @article = articles(:one)
  end

  test "create article without title, should not be valid" do
    @article.title = ""
    assert_not @article.valid?
  end

  test "create article without body, should not be valid" do
    @article.body = ""
    assert_not @article.valid?
  end

  test "create a valid article" do
    assert @article.valid?
  end

  test "create an article with to long title" do
    @article.title = "a" * 256
    assert_not @article.valid?
  end

  test "create an article with to short title" do
    @article.title = "a" * 9
    assert_not @article.valid?
  end

  test "create an article with to short body" do
    @article.body = "a" * 9
    assert_not @article.valid?
  end

end
