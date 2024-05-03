class OrganismesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_organisme, only: %i[show edit update destroy create_org_manager]

  def index
    @organismes = policy_scope(Organisme).order(name: :desc)
  end

  def show
  end

  def new
    @organisme = Organisme.new
    @organisme.build_social
  end

  def create
    org_manager = User.create!(email: params[:organisme][:org_manager_id_email], password: 'password', role: 'org_manager')
    @organisme = Organisme.new(organisme_params)
    @organisme.org_manager = org_manager
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
    if params[@organisme.type.underscore][:org_manager_id].present?
      new_manager_params = params[@organisme.type.underscore][:org_manager_id].to_i
      if new_manager_params != @organisme.org_manager_id
        # User.find(@organisme.org_manager_id).org_project_manager!
        @organisme.update!(org_manager_id: new_manager_params)
      end
    end
    if @organisme.update(organisme_params_update)
      redirect_to organisme_path(@organisme), notice: "Organisme modifié avec succès"
    else
      flash[:error] = "Organisme non modifié, veuillez réessayer"
      render :edit
    end
  end

  def destroy
    @organisme_project = OrganismeProject.find(params[:id])
    project = @organisme_project.project
    @organisme_project.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@organisme_project) }
      format.html { redirect_to edit_project_path(project), notice: 'Organisme project was successfully deleted.' }
    end
  end

  def org_project_managers_for_select
    @organisme = Organisme.find(params[:id])
    @manager_ids = [@organisme.org_manager_id].compact << OrganismeProject.where(organisme_id: @organisme.id).pluck(:org_project_manager_id).uniq
    @org_project_managers = User.where(id: @manager_ids.flatten)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update("org_project_manager_frame", partial: "org_project_managers_for_select", locals: { managers: @org_project_managers }) }
    end
  end

  private

  def organisme_params
    params.require(:organisme).permit(:name,
                                      :description,
                                      :logo,
                                      :org_manager_id,
                                      :manager_email,
                                      :type,
                                      social_attributes: %i[id
                                                            youtube_channel
                                                            youtube_video_url
                                                            x_twitter
                                                            facebook_page_url
                                                            linkedin_page_url
                                                            instagram_page_url
                                                            website_url])
  end

  def organisme_params_update
    params.permit(:name,
                  :description,
                  :logo,
                  :org_manager_id,
                  :manager_email,
                  social_attributes: %i[id
                                        youtube_channel
                                        youtube_video_url
                                        x_twitter
                                        facebook_page_url
                                        linkedin_page_url
                                        instagram_page_url
                                        website_url
                                        name])
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
