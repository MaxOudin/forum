class OrganismesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_organisme, only: [:show, :edit, :update, :destroy]
  before_action :set_socials, only: [:new, :edit]

  def index
    @organismes = Organisme.all.order(name: :desc)
  end

  def show
  end

  def new
    @organisme = Organisme.new
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
    params.require(:organisme).permit(:name, :description, :type, :user_id, :social_id)
  end

  def organisme_params_update(type)
    params.require(type.underscore).permit(:name, :description, :user_id, :social_id)
    # params <ActionController::Parameters {"_method"=>"patch", "authenticity_token"=>"0B6oTKP3_McsveGjAC-VC_nF_2dBEW95PuV_B6H6TBCQRWrupRCkxRVuOwrtUoajHr6P28sujDW5zFZxa3ww9w", "ong_fondation_internationale"=>{"name"=>"test ONG", "description"=>"test descr ong test modification", "social_id"=>"1"}, "commit"=>"Modifier Organisme", "controller"=>"organismes", "action"=>"update", "id"=>"3"} permitted: false>
    # @organisme => #<OngFondationInternationale id: 3, name: "test ONG", description: "test descr ong", type: "OngFondationInternationale", user_id: 1, social_id: nil, created_at: "2024-04-17 19:46:16.780842000 +0000", updated_at: "2024-04-17 19:46:16.780842000 +0000">

  end

  def set_organisme
    @organisme = Organisme.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_socials
    @socials = Social.order(:name)
  end

  # def organisme_class
  #   @organisme_class ||= @organisme.type.camelcase.constantize
  # end

  # def organisme_type_params(type)
  #   organisme_class.permitted_attributes_from_params(params)
  # end
end
