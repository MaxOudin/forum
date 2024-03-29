require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      article = FactoryBot.build(:article)
      expect(article).to be_valid
    end

    it "is not valid without a title" do
      article = FactoryBot.build(:article, title: nil)
      expect(article).not_to be_valid
    end

    it "is not valid without a user" do
      article = FactoryBot.build(:article, user: nil)
      expect(article).not_to be_valid
    end

    it "is not valid without content" do
      article = FactoryBot.build(:article, content: nil)
      expect(article).not_to be_valid
    end

    it "is valid without a cover image" do
      article = FactoryBot.build(:article, cover_image: nil)
      expect(article).to be_valid
    end

    it "is valid without files attached" do
      article = FactoryBot.build(:article, files: nil)
      expect(article.files).to be_empty
      expect(article).to be_valid
    end


  end
end
