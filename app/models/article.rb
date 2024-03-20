class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many_attached :files
  has_rich_text :content

  belongs_to :user

end
