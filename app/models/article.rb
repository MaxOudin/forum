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
  # has_many_attached :files
  has_one_attached :cover_image
  has_rich_text :content

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  validates :id, presence: true, uniqueness: true
  validates :public, inclusion: { in: [true, false] }, presence: true

  belongs_to :user

end
