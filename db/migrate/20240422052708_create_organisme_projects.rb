class CreateOrganismeProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :organisme_projects do |t|
      t.string :type
      t.references :organisme, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
