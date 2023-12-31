# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    user ||= User.new
    if user.sup_admin?
      can :manage, :all
    elsif user.admin?
      # can [:read, :update, :create], :all
      can :manage, User
      cannot :destroy, User, role: ['admin','sup_admin']
      can :manage, [MealAttendance,Notice, Review, Menu, Dish, Preference]
    else
      can [:read, :update], User, id: user.id
      can [:create], MealAttendance
      can [:create,:update, :destroy], Review, user_id: user.id
      can [:read], Review
      can :manage, Preference, user_id: user.id
      can [:read], Menu
      can :read, Dish
      can :read, Notice
      can [:create], MealAttendance
    end

    #   return unless user.present?
    #   can [:read, :update], User,user: user
    #   return unless user.admin?
    #   can :manage, User
    #   return unless user.sup_admin?
    #   can :manage, User
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
