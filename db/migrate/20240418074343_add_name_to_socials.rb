class AddNameToSocials < ActiveRecord::Migration[7.1]
  def change
    add_column :socials, :name, :string
  end
end
