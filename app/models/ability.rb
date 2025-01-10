class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.instructor?
      can :manage, Course
      can :manage, Lesson
    elsif user.student?
      can :read, Course
      can :read, Lesson, course: { enrolled_students: { id: user.id } }
      cannot :read, Lesson, course: { enrolled_students: { id: nil } }
    else
      can :read, Course
    end
  end
end
