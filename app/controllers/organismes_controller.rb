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
    if @organisme.update(organisme_params)
      redirect_to organisme_path(@organisme), notice: "Organisme modifié avec succès"
    else
      flash[:error] = "Organisme non modifié, veuillez réessayer"
      render :edit
    end
  end

  def destroy
    @organisme = Organisme.base_class.find(params[:id])

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

  def set_organisme
    @organisme = Organisme.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_socials
    @socials = Social.order(:name)
  end
end
