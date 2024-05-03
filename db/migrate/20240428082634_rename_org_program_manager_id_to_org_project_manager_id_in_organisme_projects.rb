class RenameOrgProgramManagerIdToOrgProjectManagerIdInOrganismeProjects < ActiveRecord::Migration[7.1]
  def change
    rename_column :organisme_projects, :org_program_manager_id, :org_project_manager_id
  end
end
