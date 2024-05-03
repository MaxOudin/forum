class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      elsif user.program_manager?
        scope.where("role <> ?", User.roles[:org_program_manager])
      else
        scope.none
      end
    end
  end

  def index?
    user.admin?
  end

  def show?
    user.team_admin?
  end

  def create?
    user.admin? || user.admin_ue? || user.program_manager? || user.tei_manager?
  end

  def edit?
    user.admin? || user.admin_ue?
  end

  def update?
    user.admin? || user.admin_ue?
  end

  def destroy?
    update?
  end
end
