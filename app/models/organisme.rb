class Organisme < ApplicationRecord
  belongs_to :user
  belongs_to :social, optional: true
  has_one_attached :logo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end


  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :type, presence: true

  # Callbacks
  before_validation :assign_default_user, on: :create

  private

  def assign_default_user
    self.user ||= User.where(admin: true).first
  end

end
