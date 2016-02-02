require 'test_helper'

class ArticlesEditTest < ActionDispatch::IntegrationTest
  def setup
    @article = articles(:one)
    session[:user_id] = users(:one).id
  end

  test "successful edit" do
    get edit_article_path(@article)
    assert_template 'articles/edit'
    title = "Helt ny title här! Titta"
    body = "Hel ny body bara för detta testet. Lorem ipsum thjena"
    patch article_path(@article), article: { title: title,
                                             body: body }

    assert_equal "Artikeln uppdaterades!", flash[:success]

    assert_redirected_to @article
    @article.reload
    assert_equal title, @article.title
    assert_equal body, @article.body
  end

  test "unsuccessful edit" do
    get edit_article_path(@article)
    assert_template 'articles/edit'
    title = ""
    body = ""
    patch article_path(@article), article: { title: title,
                                             body: body }

    assert_equal "Artikeln kunde inte uppdateras!", flash.now[:danger]
    assert_template 'articles/edit'
  end
end
