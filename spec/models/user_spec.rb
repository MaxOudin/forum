# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  role                   :integer          default("admin_ue"), not null
#
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

  describe ".admin_roles" do
    let(:admin) { create(:user, :admin) }
    let(:admin_ue) { create(:user, :admin_ue) }
    let(:coop_head) { create(:user, :coop_head) }
    let(:program_manager) { create(:user, :program_manager) }
    let(:user) { create(:user) }

    it "includes users who are admin, admin_ue, and coop_head" do
      expect(User.admin_roles).to include(admin, admin_ue, coop_head)
    end

    it "does not include regular users" do
      expect(User.admin_roles).not_to include(user)
    end

    it "does not include program_manager users" do
      expect(User.admin_roles).not_to include(program_manager)
    end
  end
end
