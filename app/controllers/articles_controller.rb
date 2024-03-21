class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authorize_article, only: [:edit, :update, :destroy]


  def index
    @articles = policy_scope(Article).order(created_at: :desc)
  end

  def show
  end

  def new
    @article = Article.new
    authorize_article
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    authorize_article

    if @article.save
      flash[:notice] = "Article créé avec succès"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article non créé, veuillez réessayer"
      render :new
    end
  end


  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "Article modifié avec succès"
    else
      flash[:error] = "Article non modifié, veuillez réessayer"
      render :edit
    end
    # if @article.update(article_params.except(:files))
    #   update_files
    #   redirect_to article_path(@article), notice: "Article modifié avec succès"
    # else
    #   flash[:error] = "Article non modifié, veuillez réessayer"
    #   render :edit
    # end
  end


  def destroy
    if @article.destroy
      flash[:notice] = "Article supprimé avec succès"
      redirect_to articles_path, status: :see_other
    else
      flash[:error] = "Article non supprimé, veuillez réessayer"
      render :show, status: :unprocessable_entity
    end
  end

  def remove_attachment
    begin
    @article = Article.find(params[:id])
    authorize @article, :update?

    attachment_id = params[:attachment_id]
    @attachment = ActiveStorage::Attachment.find(attachment_id)

    if @attachment.record_id == @article.id && @attachment.destroy
      redirect_to edit_article_path(@article), notice: "Pièce jointe supprimée avec succès"
    else
      render edit_article_path(@article), status: :unprocessable_entity, alert: "Pièce jointe non supprimée, veuillez réessayer"
    end
    rescue => error
      redirect_to edit_article_path(@article), alert: error.message
    end
  end

  private

  def update_files
    if params[:article][:files]
      params[:article][:files].each do |file|
        @article.files.attach(file)
      end
    end
  end

  def article_params
    # params.require(:article).permit(:title, :content, :public, files: [])
    params.require(:article).permit(:title, :content, :public, :cover_image)
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
