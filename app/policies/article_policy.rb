class ArticlePolicy < ApplicationPolicy

  def show?
    true
  end

  def index?
    true
  end

  def new?
    user || user.admin?
  end

  def create?
    user || user.admin?
  end

  def update?
    user && (record.user == user || user.admin?)
  end

  def destroy?
    user && (record.user == user || user.admin?)
  end
end
