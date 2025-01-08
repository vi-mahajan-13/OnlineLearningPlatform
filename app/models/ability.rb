class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.instructor?
      can :manage, :all
    elsif user.student?
      can :read, :course
      can :read, :lesson
    else
      can :read, :course
    end
  end
end
