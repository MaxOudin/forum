require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "associations" do
    it { should have_many(:notifications) }
  end
end
