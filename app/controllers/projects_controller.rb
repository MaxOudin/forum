class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy validate ]
  # before_action :authorize_project, only: [:show, :edit, :update, :destroy, :validate]

  def index
    @projects = Project.includes(chef_de_file: :org_project_manager).all
  end

  def show; end

  def new
    @project = Project.new
    @organismes = Organisme.all
  end

  def create
    @project = Project.new(project_params)
    # raise
    if current_user&.program_manager? || current_user&.admin?
      @project.manager = current_user
    else
      @project.manager = User.where(admin: true).first
    end
    if @project.save
      if params[:project][:org_project_manager_email].present? || params[:project][:org_proj_man_id].present?
        organisme_project_manager_id = find_or_create_org_program_manager
        organisme = find_or_create_organisme

        ChefDeFile.create!(
          project: @project,
          organisme: organisme,
          org_project_manager_id: organisme_project_manager_id
        )
      end
      redirect_to @project, notice: 'Projet créé avec succès.'
    else
      @organismes = Organisme.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @organismes = Organisme.all
    @project.social ||= @project.build_social
    @project.organisme_projects.build
  end

  def update
    # @organisme_project = OrganismeProject.new
    # @organisme_project.save(organisme_params)
    # @project.org_project_manager = @project.chef_de_file.org_project_manager
    if @project.update(project_params)
      Rails.logger.debug "Project after update: #{@project}"
      redirect_to edit_project_path(@project), notice: "Projet modifié avec succès"
    else
      flash[:error] = "Projet non modifié, veuillez réessayer"
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Projet supprimé avec succès.'
    else
      redirect_to projects_path, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_project
    authorize @project
  end

  def find_or_create_organisme
    if params[:project][:organisme_id].present?
      Organisme.find(params[:project][:organisme_id])
    elsif params[:project][:new_organisme_name].present?
      Organisme.create!(
        name: params[:project][:new_organisme_name],
        type: params[:project][:org_type],
        org_manager_id: find_or_create_org_program_manager
      )
    end
  end

  def find_or_create_org_program_manager
    user = if params[:project][:org_project_manager_email].present?
             find_or_initialize_manager_by_email(params[:project][:org_project_manager_email])
           elsif params[:project][:org_proj_man_id].present?
             User.find_by(id: params[:project][:org_proj_man_id])
           end

    return user.id if user.present?

    fallback_manager.id
  end

  def project_params
    params.require(:project).permit(:title,
                                    :description,
                                    :start_date,
                                    :end_date,
                                    :budget,
                                    :status,
                                    :published,
                                    :organisme_id,
                                    :new_organisme_name,
                                    :org_type,
                                    :org_project_manager_email,
                                    :org_proj_man_id,
                                    social_attributes: %i[ id
                                                           youtube_channel
                                                           youtube_video_url
                                                           x_twitter
                                                           facebook_page_url
                                                           linkedin_page_url
                                                           instagram_page_url
                                                           website_url
                                                           name ],
                                    organisme_projects_attributes: %i[id
                                                                      type
                                                                      budget
                                                                      organisme_id
                                                                      project_id
                                                                      org_project_manager_id])
  end

  def find_or_initialize_manager_by_email(email)
    User.find_or_initialize_by(email: email).tap do |user|
      if user.new_record?
        user.password = SecureRandom.hex(10)  # Generate a secure random password
        user.role = 'org_project_manager'
        user.save!
        # Optionally, send an email to the user to notify them of their account creation
        # UserMailer.account_setup(user).deliver_later
      end
    end
  end

  def fallback_manager
    User.find_by(admin: true) || raise("No fallback admin user found")
  end
end
