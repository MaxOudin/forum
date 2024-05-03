class OrganismeProjectsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @organisme_project = OrganismeProject.new
    respond_to do |format|
      format.html { render partial: "organisme_projects/form" }
    end
  end

  def create
    @organisme_project = OrganismeProject.new(organisme_project_params)
    if @organisme_project.save
      redirect_to edit_project_path(@project), notice: 'Organisme Project was successfully added.'
    else
      render turbo_stream: turbo_stream.replace("organisme_project_form", partial: "organisme_projects/form", locals: { organisme_project: @organisme_project, project: @project })
    end
  end

  def edit
    @organisme_project = OrganismeProject.find(params[:id])
  end

  def update
    @organisme_project = OrganismeProject.new(organisme_project_params)
    if @organisme_project.update(organisme_project_params)
      redirect_to edit_project_path(@organisme_project.project), notice: 'Le lien a été mis à jour.'
    else
      render :edit
    end
  end

  def destroy
    @organisme_project = OrganismeProject.find(params[:id])
    @organisme_project.destroy
    redirect_to edit_project_path(@organisme_project.project), notice: 'Le lien a été supprimé.'
  end

  private

  def organisme_project_params
    params.require(:organisme_project).permit(:project_id, :organisme_id, :type, :org_project_manager_id)
  end
end
