class ArticlesController < ApplicationController
  before_action :fetch_article, only: [:show, :destroy, :edit, :update]

  def show

  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "Artikel sparades!"
      redirect_to current_user
    else
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
end
