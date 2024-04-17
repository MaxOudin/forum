class CreateOrganismes < ActiveRecord::Migration[7.1]
  def change
    create_table :organismes do |t|
      t.string :name
      t.text :description
      t.string :type
      t.references :user, null: false, foreign_key: true
      t.references :social, null: false, foreign_key: true

      t.timestamps
    end
  end
end
