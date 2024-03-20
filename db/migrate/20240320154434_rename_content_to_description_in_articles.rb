class RenameContentToDescriptionInArticles < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :content, :description
  end
end
