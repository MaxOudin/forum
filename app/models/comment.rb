class Comment < ApplicationRecord
  extend Mobility
  translates :content, type: :text

  belongs_to :article
  belongs_to :user

  validates :content, presence: true
end
