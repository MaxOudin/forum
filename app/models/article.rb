class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_many_attached :files

  belongs_to :user

  after_initialize :set_default_public

  private

  def set_default_public
    self.public ||= false
  end
end
