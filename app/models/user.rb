class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  belongs_to :permission
  has_many :articles, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  # Callbacks
  before_save :assign_default_permission, if: :new_record?

  private

  def assign_default_permission
    self.permission = Permission.find(1)
  end
end
