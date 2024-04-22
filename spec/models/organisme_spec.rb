# == Schema Information
#
# Table name: organismes
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  type        :string
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Organisme, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:internal_code) }
  end
end
