class RemoveSocialIdFromOrganismes < ActiveRecord::Migration[7.1]
  def change
    remove_reference :organismes, :social
  end
end
