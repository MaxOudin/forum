class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present? && user.admin?
        scope.all
      elsif user.present?
        scope.where(public: true).or(scope.where(user_id: user.id))
      else
        scope.where(public: true)
      end
    end
  end

  def index?
    user.admin?
  end

  def show?
    record.public? || (user.present? && (user.admin? || record.user == user))
  end

  def create?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    user.present? && (user.admin? || record.user == user)
  end

  def destroy?
    update?
  end
end
