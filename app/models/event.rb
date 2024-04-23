# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  type       :string
#  params     :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Event < ApplicationRecord
  has_many :notifications
end
