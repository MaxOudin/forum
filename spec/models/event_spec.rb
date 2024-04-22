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
require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "associations" do
    it { should have_many(:notifications) }
  end
end
