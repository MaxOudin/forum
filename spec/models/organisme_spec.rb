require 'rails_helper'

RSpec.describe Organisme, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    # it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:type) }
  end
end
