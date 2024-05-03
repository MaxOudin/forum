class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.bigint :budget
      t.bigint :manager_id

      t.timestamps
    end

    add_index :projects, :manager_id
    add_foreign_key :projects, :users, column: :manager_id
  end
end
