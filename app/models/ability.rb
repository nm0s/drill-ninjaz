class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :create, :read, :update, :destroy, to: :crud

    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    can :crud, Attempt do |attempt|
      attempt.user == user
    end

    if user.is_admin?
      can :crud, DrillGroup do |drill_group|
        drill_group.user == user
      end

      can :crud, Question do |question|
        question.drill_group&.user == user
      end

      can :crud, Solution do |solution|
        solution.user == user
      end
    end

      # if user.is_admin?
      #   can :manage, :all
      # else
      #   can :read, :all
      # end
    #
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
