class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:new, :create, :destroy, :edit, :update]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authorize_article, only: [:show, :edit, :update, :destroy]


  def index
    @articles = Article.all
    @articles = policy_scope(Article)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new
    @article.user = current_user

    if @article.save
      flash[:notice] = "Article créé avec succès"
      redirect_to user_article_path(@user, @article)
    else
      flash[:error] = "Article non créé, veuillez réessayer"
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article modifié avec succès"
      redirect_to user_article_path(@user, @article)
    else
      flash[:error] = "Article non modifié, veuillez réessayer"
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article supprimé avec succès"
      redirect_to user_articles_path(@user), status: :see_other
    else
      flash[:error] = "Article non supprimé, veuillez réessayer"
      render :show, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, files: [])
  end

  def set_user
    @user = current_user
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def authorize_article
    authorize @article
  end

end
