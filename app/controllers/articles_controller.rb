class ArticlesController < ApplicationController
  # Controller that handles everything about the articles.
  # Creates, updates, destroys & reads.

  ARTICLE_SAVED_FLASH       = "Artikel sparades"
  ARTICLE_SAVE_FAILED_FLASH = "Artikel kunde inte sparas!"
  ARTICLE_REMOVED_FLASH     = "Artikeln togs bort!"
  ARTICLE_UPDATED_FLASH     = "Artikeln uppdaterades!"
  ARTICLE_UPDATE_FAIL_FLASH = "Artikeln kunde inte uppdateras!"

  before_action :fetch_article, only: [:show, :destroy, :edit, :update]
  before_action :check_if_logged_in, only: [:create, :destroy, :update, :edit, :new]
  before_action :check_privilege, only: [:new, :create, :destroy]

  def create
    @article = Article.new(article_params)

    if @article.save
      current_user.articles << @article
      flash[:success] = ARTICLE_SAVED_FLASH
      redirect_to articles_path
    else
      flash.now[:danger] = ARTICLE_SAVE_FAILED_FLASH
      render 'new'
    end
  end

  def new
    @article = Article.new
  end

  def destroy
    @article.destroy
    flash[:success] = ARTICLE_REMOVED_FLASH
    redirect_to articles_path
  end

  def edit
  end


  def update
    if @article.update_attributes(article_params)
      flash[:success] = ARTICLE_UPDATED_FLASH
      redirect_to @article
    else
      flash.now[:danger] = ARTICLE_UPDATE_FAIL_FLASH
      render 'edit'
    end
  end

  def index
    if params[:search]
      @articles = Article.paginate(:page => params[:page], :per_page => 3).search(params[:search])
    else
      @articles = Article.paginate(:page => params[:page], :per_page => 3)
    end
  end

  private
  # Strong parameters that whitelists params that is used in this controller.

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def fetch_article
      @article = Article.find(params[:id])
    end

    def check_privilege
      redirect_to current_user unless current_user.admin? ||
                                      current_user.editor?
    end
end
