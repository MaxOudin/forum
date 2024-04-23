class AddSocialableToSocials < ActiveRecord::Migration[7.1]
  def change
    add_reference :socials, :socialable, polymorphic: true, null: false
  end
end
