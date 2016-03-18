class AdminArticleTest < ActionDispatch::IntegrationTest
  # Testing a sequence of admin logging and and fiddling with an article

  ARTICLE_SAVED_FLASH       = "Artikel sparades!"
  ARTICLE_SAVE_FAILED_FLASH = "Artikel kunde inte sparas!"
  ARTICLE_REMOVED_FLASH     = "Artikeln togs bort!"
  ARTICLE_UPDATED_FLASH     = "Artikeln uppdaterades!"
  ARTICLE_UPDATE_FAIL_FLASH = "Artikeln kunde inte uppdateras!"

  def setup
    @user = users(:one)
    @user.role = roles(:user)
  end

  test "admin logs in adds article edits it and deletes it" do
    # Admin logs in
    https!
    get "/login"
    assert_response :success

    post_via_redirect "/login", session: { user_name: @user.user_name,
                                           password: "password" }

    assert_equal "/users/#{users(:one).id}", path

    # Admin adds an article
    get "/articles/new"
    assert_response :success

    post_via_redirect "/articles", article: { id: 2, title: "Artikel skapad av admin", body: "Nån sorts artikel idk hej hej tjoho", user: @user }
    assert_equal "/articles", path
    assert_equal ARTICLE_SAVED_FLASH, flash[:success]

    # Admin views the created article
    get "/articles/2"
    assert_response :success

    # Admin edits the created article
    put_via_redirect "/articles/2", article: { title: "Titeln ändrades av admin", body: "Nån sorts artikel idk hej hej tjoho" }
    assert_equal '/articles/2', path
    assert_equal ARTICLE_UPDATED_FLASH, flash[:success]

    # Admin removes the article
    delete_via_redirect "/articles/2"
    assert_equal '/articles', path
    assert_equal ARTICLE_REMOVED_FLASH, flash[:success]

    # Admin logs out
    delete logout_path
    assert_redirected_to root_url
  end
end
