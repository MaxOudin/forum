# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  type          :string
#  event_id      :bigint           not null
#  recipent_type :string           not null
#  recipent_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Notification < ApplicationRecord
  belongs_to :event
  belongs_to :recipent, polymorphic: true
end
