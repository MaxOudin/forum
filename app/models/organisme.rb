# == Schema Information
#
# Table name: organismes
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  type        :string
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Organisme < ApplicationRecord
  belongs_to :user
  has_one :social, as: :socialable
  after_create :create_associated_social

  has_one_attached :logo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :type, presence: true

  before_validation :assign_default_user, on: :create

  accepts_nested_attributes_for :social

  def self.types_for_select
    descendants.map { |type| [type.model_name.human, type.name] }
  end

  private

  def assign_default_user
    self.user ||= User.where(admin: true).first
  end

  def create_associated_social
    create_social
  end
end
