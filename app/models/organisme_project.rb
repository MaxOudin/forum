# == Schema Information
#
# Table name: organisme_projects
#
#  id                     :bigint           not null, primary key
#  type                   :string
#  organisme_id           :bigint           not null
#  project_id             :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  org_project_manager_id :bigint
#  budget                 :bigint           default(0)
#
class OrganismeProject < ApplicationRecord
  before_save :set_default_org_project_manager_id

  belongs_to :organisme
  belongs_to :project
  belongs_to :org_project_manager, class_name: 'User', foreign_key: 'org_project_manager_id', optional: true

  validates :project_id, uniqueness: { scope: :type, message: "should have one chef de file" }, if: -> { type == "ChefDeFile" }
  validates :organisme_id, presence: true
  validates :type, presence: true
  validates :budget, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :organisme_must_be_unique_in_project

  scope :order_by_type, -> { order(Arel.sql("CASE type WHEN 'ChefDeFile' THEN 0
                                                       WHEN 'MembreConsortium' THEN 1
                                                       WHEN 'Cofinanceur' THEN 2
                                                       ELSE 3 END")) }

  private

  def organisme_must_be_unique_in_project
    return if project.nil?

    if project.organisme_projects.where.not(id: id).exists?(organisme_id: organisme_id)
      errors.add(:organisme_id, "is already associated with this project")
    end
  end

  def set_default_org_project_manager_id
    self.org_project_manager_id ||= nil unless type == 'ChefDeFile'
  end
end
