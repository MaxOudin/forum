class Social < ApplicationRecord
  has_one :organisme

  validates :name, presence: true, uniqueness: true

end
