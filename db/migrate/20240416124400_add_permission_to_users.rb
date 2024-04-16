class AddPermissionToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :permission, foreign_key: true
  end
end
