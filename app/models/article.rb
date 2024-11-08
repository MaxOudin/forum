# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  public     :boolean          default(FALSE)
#
class Article < ApplicationRecord
  include TranslatableRichText
  extend Mobility
  translates :title, type: :string

  belongs_to :user

  has_rich_text :content
  has_translated_rich_text :content

  has_one_attached :cover_image
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :public, inclusion: { in: [true, false] }

end
