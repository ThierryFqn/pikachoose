class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    # record.pokemon.user != user
    true
  end

  def new?
    create?
  end

  def accepted?
    true
  end

  def denied?
    true
  end

  def cancelled?
    true
  end
end
