# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  start_date  :date
#  end_date    :date
#  budget      :bigint
#  manager_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type        :string
#  status      :integer          default("upcoming"), not null
#  published   :boolean          default(FALSE), not null
#  social_id   :bigint
#
class Project < ApplicationRecord
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
  has_many :organisme_projects, dependent: :destroy
  has_many :organismes, through: :organisme_projects
  has_one :chef_de_file, -> { where(type: 'ChefDeFile') }, class_name: 'OrganismeProject'
  has_one :org_project_manager, through: :chef_de_file, source: :org_project_manager

  has_one :social, as: :socialable
  accepts_nested_attributes_for :social
  accepts_nested_attributes_for :organisme_projects, allow_destroy: true

  validates :title, presence: true
  validates :manager_id, presence: true
  validates :budget, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  validate :end_date_after_start_date

  enum status: {
    upcoming: 0,
    inprogress: 1,
    closed: 2,
    archived: 3
  }

  before_save :update_status

  attr_accessor :org_type, :new_organisme_name, :organisme_id, :org_project_manager_email, :org_proj_man_id

  def organisme_projects=(organisme_projects)
    organisme_projects.values.each do |op_attr|
      op = OrganismeProject.find_or_create_by(op_attr)
      self.organisme_projects << op
    end
  end

  def chef_de_file_managers
    User.where(id: OrganismeProject.where(organisme_id: chef_de_file.organisme.id).pluck(:org_project_manager_id).uniq)
  end

  private

  def end_date_after_start_date
    # return if end_date.blank? || start_date.blank?
    return unless end_date < start_date

    errors.add(:end_date, "must be after the start date")
  end

  def update_status
    self.status = if Date.today < start_date
                    'upcoming'
                  elsif Date.today >= start_date && Date.today <= end_date
                    'inprogress'
                  elsif Date.today > end_date
                    if end_date < 12.months.ago
                      'archived'
                    else
                      'closed'
                    end
                  end
  end
end
