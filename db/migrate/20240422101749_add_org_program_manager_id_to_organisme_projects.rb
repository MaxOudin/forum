class AddOrgProgramManagerIdToOrganismeProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :organisme_projects, :org_program_manager_id, :bigint
    add_index :organisme_projects, :org_program_manager_id
  end
end
