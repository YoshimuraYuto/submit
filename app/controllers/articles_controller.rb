class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy]
  def index
    @articles = Article.all
    @articles = Article.page params[:page]
    if params[:article].present?
        @articles = @articles.search_with_title(params[:article][:title])
        @keyword = params[:article][:title]
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
    
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
