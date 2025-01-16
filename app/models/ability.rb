class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.instructor?
      can :create, Course
      can :create, Lesson, course: { user_id: user.id } 
      can :manage, Course, user_id: user.id
      can :manage, Lesson, course: { user_id: user.id }
      can :read, Course
      can :read, Lesson, course: { user_id: user.id }
    elsif user.student?
      can :read, Course
      can :read, Lesson, course: { enrolled_students: { id: user.id } }
      cannot :read, Lesson, course: { enrolled_students: { id: nil } }
    end
  end
end
