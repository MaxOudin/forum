class DropPermissionsTable < ActiveRecord::Migration[7.1]
  def up
    remove_column :users, :permission_id
    drop_table :permissions
  end

  def down
    create_table :permissions do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    add_column :users, :permission_id, :integer
    add_index :users, :permission_id
  end
end
