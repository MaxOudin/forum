class RenameUserIdToOrgManagerIdInOrganismes < ActiveRecord::Migration[7.1]
  def change
    rename_column :organismes, :user_id, :org_manager_id
  end
end
