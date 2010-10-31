class Ability

  include CanCan::Ability

  def initialize user
    return if user.nil?

    can [:read, :comment], Recipe, :user_id => user.friends.map(&:id)
    can :manage, Recipe, :user_id => user.id
    can :manage, Comment
  end

end
