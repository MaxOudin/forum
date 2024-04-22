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
require 'rails_helper'

RSpec.describe Notification, type: :model do

end
