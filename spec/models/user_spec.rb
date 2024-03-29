require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is not valid with a duplicate email" do
      FactoryBot.build(:user, email: 'test@example.com')
      user = FactoryBot.build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  context "Check admin users" do
    it "creates an admin user" do
      admin = FactoryBot.build(:admin)
      expect(admin.admin).to be true
    end
  end

  context "when creating non-admin users" do
    it "creates a non-admin user" do
      user = FactoryBot.build(:user)
      expect(user.admin).to be false
    end
  end
end