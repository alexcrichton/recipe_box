class Ability

  include CanCan::Ability

  def initialize user
    return if user.nil?

    can :manage, Recipe, :user_id => user.id
    can :read, :all
  end

end
