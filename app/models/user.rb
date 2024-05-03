# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  role                   :integer          default("admin_ue"), not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :articles, dependent: :destroy
  has_many :notifications, as: :recipent, dependent: :destroy
  has_many :managed_projects, class_name: 'Project', foreign_key: 'manager_id'
  has_many :organisme_managed, class_name: 'Organisme', foreign_key: 'org_manager_id'
  has_many :organisme_projects_managed, class_name: 'OrganismeProject', foreign_key: 'org_project_manager_id'
  has_many :projects_managed, through: :organisme_projects_managed, source: :project
  # Validations
  # validates :email, presence: true, uniqueness: { case_sensitive: false }
  # validates :password, presence: true, length: { minimum: 6 }

  enum role: { admin_ue: 0,
               coop_head: 1,
               section_head: 2,
               tei_manager: 3,
               program_manager: 4,
               org_project_manager: 5,
               org_manager: 6,
               strategie_editor: 7,
               publication_editor: 8,
               user: 9 }

  validate :role_change_authorization, on: :update

  scope :admin_roles, -> {
    where("admin = :true OR role = :admin_ue OR role = :coop_head",
           true: true, admin_ue: roles[:admin_ue], coop_head: roles[:coop_head]) }

  def team_admin?
    admin || self.admin_ue? || self.coop_head?
  end

  def project_creator?
    admin || self.admin_ue || self.program_manager || self.tei_manager
  end

  def self.organisme_users(organisme)
    manager_ids = [organisme.org_manager_id].compact
    manager_ids += OrganismeProject.where(organisme_id: organisme.id).pluck(:org_project_manager_id).uniq
    where(id: manager_ids.flatten)
  end

  private

  def role_change_authorization
    return if admin?

    if program_manager?
      unless changing_to_org_program_manager?
        errors.add(:role, "vous n'êtes pas autorisé à changer les rôles.")
      end
    else
      errors.add(:role, "vous n'êtes pas autorisé à changer les rôles.") if role_changed?
    end
  end

  def changing_to_org_program_manager?
    role_change_to_org_project_manager? && role_was != 'org_project_manager'
  end

  def role_change_to_org_program_manager?
    role == 'org_project_manager'
  end
end
