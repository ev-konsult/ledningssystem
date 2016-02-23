class ArticlesController < ApplicationController
  before_action :fetch_article, only: [:show, :destroy, :edit, :update]
  before_action :check_if_logged_in

  def show

  end

  def create
    @article = Article.new(article_params)

    if @article.save
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
    @articles = Article.all
  end

  private

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def fetch_article
      @article = Article.find(params[:id])
    end

    def check_if_logged_in
      redirect_to root_path unless logged_in?
    end
end
