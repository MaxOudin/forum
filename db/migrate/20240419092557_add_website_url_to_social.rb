class AddWebsiteUrlToSocial < ActiveRecord::Migration[7.1]
  def change
    add_column :socials, :website_url, :string
  end
end
