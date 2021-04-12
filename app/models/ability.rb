# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :manage, ShortLink, user_id: user.id
    end
    can [:show, :create], ShortLink
  end
end
