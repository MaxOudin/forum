class Organisme < ApplicationRecord
  belongs_to :user
  has_one :social

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  # validates :address, presence: true
  # validates :type, presence: true

  # Callbacks
  before_validation :assign_default_user, on: :create

  private

  def assign_default_user
    self.user ||= User.where(admin: true).first
  end
end
