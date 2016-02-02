require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  def setup
    @article = articles(:one)
    @user = users(:one)
    session[:user_id] = @user.id
  end

  test "make sure valid article is saved" do
    assert_difference("Article.count", 1) do
      post :create, article: { title: @article.title,
                               body: @article.body }
    end

    assert_equal "Artikel sparades!", flash[:success]
    assert_redirected_to @user
  end

  test "successful edit" do
    title = "Helt ny title här! Titta"
    body = "Hel ny body bara för detta testet. Lorem ipsum thjena"

    patch :update, id: @article, article: { title: title, body: body }
    assert_equal "Artikeln uppdaterades!", flash[:success]
    assert_redirected_to @article

    @article.reload
    assert_equal title, @article.title
    assert_equal body, @article.body
  end

  test "unsuccessful edit" do
    title = "kort"
    body = "så kort"

    patch :update, id: @article, article: { title: title, body: body }
    assert_equal "Artikeln kunde inte uppdateras!", flash.now[:danger]
    assert_template 'edit'

    @article.reload
    assert_not_equal title, @article.title
    assert_not_equal body, @article.body
  end

  test "make sure invalid article is not saved" do
    assert_no_difference("Article.count") do
      post :create, article: { title: "",
                               body: "" }
    end

    assert_equal "Artikel kunde inte sparas!", flash.now[:danger]
    assert_template 'new'
  end

  test "make sure article is destroyed" do
    assert_difference("Article.count", -1) do
      delete :destroy, id: @article.id
    end

    assert_equal "Artikeln togs bort!", flash[:success]
  end
end
