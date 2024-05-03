class AddBudgetToOrganismeProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :organisme_projects, :budget, :bigint, default: 0
  end
end
