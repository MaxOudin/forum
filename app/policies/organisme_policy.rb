class OrganismePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.team_admin?
        scope.all
      elsif user.org_project_manager?
        scope.where(org_manager_id: user.id)
      end
    end
  end

  def show?
    record.public? || (user.present? && (user.admin? || record.user == user))
  end

  def create?
    user.present? && (user.admin? || user.program_manager? || user.tei_manager?)
  end

  def update?
    user.present? && user.admin? || record.user == user
  end

  def destroy?
    update?
  end
end

