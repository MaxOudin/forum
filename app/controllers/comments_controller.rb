class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article_and_user

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = @user

    if @comment.save
      redirect_to @article
    else
      redirect_to @article, alert: 'Erreur lors de l\'ajout du commentaire.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content_en, :content_fr, :content_es, :content_pt)
  end

  def set_article_and_user
    @article = Article.find(params[:article_id])
    @user = current_user
  end
end
