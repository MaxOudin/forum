require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(6) }

    it "validates presence of password on create" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  describe "associations" do
    it { should have_many(:articles).dependent(:destroy) }
    # it { should have_many(:notifications).dependent(:destroy) }
  end

end
