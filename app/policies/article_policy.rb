class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present? && user.admin?
        scope.all
      elsif user.present? && record.user == user?
        scope.where(user: user)
      else
        scope.where(public: true)
      end
    end
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || record.user == user || record.public?
  end

  def create?
    user.admin?
  end

  def update?
    user.present? && (user.admin? || record.user == user)
  end

  def destroy?
    update?
  end
end
