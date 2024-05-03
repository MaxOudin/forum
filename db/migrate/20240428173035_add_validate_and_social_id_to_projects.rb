class AddValidateAndSocialIdToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :published, :boolean, null:false, default: false
    add_reference :projects, :social, foreign_key: true
  end
end
