class Article < ApplicationRecord
  has_many_attached :files
  has_one_attached :cover_image
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user

end
