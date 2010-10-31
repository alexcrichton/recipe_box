class Ability

  include CanCan::Ability

  def initialize user
    # Facebook rakes pages liked, should let them read them.
    can :read, Recipe

    return if user.nil?

    can :comment, Recipe, :user_id => user.friends.map(&:id)
    can :manage, Recipe, :user_id => user.id
    can :manage, Comment
  end

end
