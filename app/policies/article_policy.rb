class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.nil? ? scope.all : (user.admin? ? scope.all : scope.where(user: user))
    end

    def show?
      true
    end

    def index?
      true
    end

    def new?
      true
    end

    def create?
      true
    end

    def update?
      record.user == user
    end

    def destroy?
      record.user == user
    end
  end
end
