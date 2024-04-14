class Notification < ApplicationRecord
  belongs_to :event
  belongs_to :recipient, polymorphic: true
end
