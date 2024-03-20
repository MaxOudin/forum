class AddPublicToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :public, :boolean, default: false
  end
end
