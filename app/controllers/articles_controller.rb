class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create, :destroy, :edit, :update]

  def index
    @articles = Article.all
  end

  def show
    # authorize @article
  end

  def new
    @article = Article.new(public: false)
    # authorize @article
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    # authorize @article

    if @article.save
      flash[:notice] = "Article créé avec succès"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article non créé, veuillez réessayer"
      render :new
    end
  end

  def edit
    # authorize @article
  end

  def update
    # authorize @article
    if @article.update(article_params)
      flash[:notice] = "Article modifié avec succès"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article non modifié, veuillez réessayer"
      render :edit
    end
  end

  def destroy
    # authorize @article
    if @article.destroy
      flash[:notice] = "Article supprimé avec succès"
      redirect_to articles_path, status: :see_other
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

end
