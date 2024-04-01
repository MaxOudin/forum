require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    subject { build(:article) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should belong_to(:user).required(true) }
    it { should validate_presence_of(:id) }
    it { should validate_presence_of(:public) }

    it "is valid without files attached" do
      article = build(:article)
      expect(article).to be_valid
    end

    it { should_not validate_presence_of(:files) }
    it { should_not validate_presence_of(:cover_image) }
  end

end
