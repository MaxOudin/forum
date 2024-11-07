class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = policy_scope(Article).order(created_at: :desc)
  end

  def show
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    authorize @article

    if @article.save!
      @article.cover_image.attach(params[:article][:cover_image])
      flash[:notice] = "Article créé avec succès"
      redirect_to article_path(@article)
    else
      flash[:error] = "Article non créé, veuillez réessayer"
      render :new
    end
  end

  def edit
    authorize @article
  end

  def update
    authorize @article

    if params[:article][:cover_image].present?
      @article.cover_image.attach(params[:article][:cover_image])
    end

    if @article.update(article_params)
      redirect_to article_path(@article), notice: "Article modifié avec succès"
    else
      flash[:error] = "Article non modifié, veuillez réessayer"
      render :edit
    end
  end

  def destroy
    authorize @article
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

  def create_comment
    @article = Article.find(params[:id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @article, notice: 'Commentaire ajouté avec succès.'
    else
      redirect_to @article, alert: 'Erreur lors de l\'ajout du commentaire.'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title_fr, :title_en, :title_es, :title_pt, :content, :public, :cover_image)
  end

  def set_user
    @user = current_user
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content_en, :content_fr, :content_es, :content_pt, :user_id, :article_id)
  end
end
