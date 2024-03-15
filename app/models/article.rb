class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many_attached :files

  belongs_to :user

end
