class OrganismesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_organisme, only: [:show, :edit, :update, :destroy ]
  def index
    @organismes = Organisme.all.order(name: :desc)
  end

  def show
  end

  def new
    @organisme = Organisme.new
    @organisme.build_social
  end

  def create
    @organisme = Organisme.new(organisme_params)
    @organisme.user = current_user
    if @organisme.save
      flash[:notice] = "Organisme créé avec succès"
      redirect_to organisme_path(@organisme)
    else
      flash[:error] = "Organisme non créé, veuillez réessayer"
      render :new
    end
  end

  def edit
  end

  def update
    if @organisme.update(organisme_params_update(@organisme[:type]))
      redirect_to organisme_path(@organisme), notice: "Organisme modifié avec succès"
    else
      flash[:error] = "Organisme non modifié, veuillez réessayer"
      render :edit
    end
  end

  def destroy
    if @organisme.destroy
      flash[:notice] = "Organisme supprimé avec succès"
      redirect_to organismes_path, status: :see_other
    else
      flash[:error] = "Organisme non supprimé, veuillez réessayer"
      render :show, status: :unprocessable_entity
    end
  end

  private

  def organisme_params
    params.require(:organisme).permit(:name,
                                      :description,
                                      :logo,
                                      :user_id,
                                      :type,
                                      social_attributes: [:id,
                                                          :youtube_channel,
                                                          :youtube_video_url,
                                                          :x_twitter,
                                                          :facebook_page_url,
                                                          :linkedin_page_url,
                                                          :instagram_page_url,
                                                          :website_url])
  end

  def organisme_params_update(type)
    params.require(type.underscore).permit(:name,
                                           :description,
                                           :logo,
                                           :user_id,
                                           social_attributes: [:id,
                                                               :youtube_channel,
                                                               :youtube_video_url,
                                                               :x_twitter,
                                                               :facebook_page_url,
                                                               :linkedin_page_url,
                                                               :instagram_page_url,
                                                               :website_url])
  end

  def set_organisme
    @organisme = Organisme.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def social_params
    params.require(:social).permit(:name,
                                   :facebook_page_url,
                                   :youtube_video_url,
                                   :youtube_channel,
                                   :x_twitter,
                                   :linkedin_page_url,
                                   :instagram_page_url,
                                   :website_url,
                                   :organisme_id)
  end
end
