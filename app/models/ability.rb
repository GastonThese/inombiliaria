# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :tenant
      can :read, :all # TODO Puede leer lo que sea de el y su edificio
    end

    if user.has_role? :owner
      can :read, :all # TODO Puede leer lo que sea de el, sus propiedades y su edificio
    end
  end
end
