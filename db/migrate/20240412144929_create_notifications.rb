class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :type
      t.belongs_to :event, null: false
      t.belongs_to :recipent, polymorphic: true, null: false

      t.timestamps
    end
  end
end
