class Notification < ApplicationRecord
  belongs_to :event
  belongs_to :recipent, polymorphic: true
end
