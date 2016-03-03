class ArticlesController < ApplicationController
  before_action :fetch_article, only: [:show, :destroy, :edit, :update]
  before_action :check_if_logged_in, only: [:create, :destroy, :update, :edit, :new]
  before_action :check_privilege, only: [:new, :create, :destroy]

  def show

  end

  def create
    @article = Article.new(article_params)

    if @article.save
      current_user.articles << @article
      flash[:success] = "Artikel sparades!"
      redirect_to current_user
    else
      flash.now[:danger] = "Artikel kunde inte sparas!"
      render 'new'
    end
  end

  def new
    @article = Article.new
  end

  def destroy
    @article.destroy
    flash[:success] = "Artikeln togs bort!"
    redirect_to articles_path
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = "Artikeln uppdaterades!"
      redirect_to @article
    else
      flash.now[:danger] = "Artikeln kunde inte uppdateras!"
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
