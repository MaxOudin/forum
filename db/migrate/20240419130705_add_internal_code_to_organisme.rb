class AddInternalCodeToOrganisme < ActiveRecord::Migration[7.1]
  def change
    add_column :organismes, :internal_code, :string
  end
end
