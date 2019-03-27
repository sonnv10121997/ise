class Ability
  include CanCan::Ability

  def initialize(user)
    if user.Admin?
      dashboard_rules
      can :manage, User
    elsif user.Manager?
      dashboard_rules
      manager_rules
    elsif user.Staff?
      dashboard_rules
      staff_rules
    else
      student_rules
      can :read, Student, id: user.id
    end
  end

  private

  def dashboard_rules
    can :access, :rails_admin
    can :dashboard, :all
  end

  def manager_rules
    can :manage, manager_manage_authorization.flatten!
    can :update, User
    can :read, :all
  end

  def staff_rules
    can :manage, staff_manage_authorization.flatten!
    can :update, Event
    can :read, staff_read_authorization.flatten!
  end

  def student_rules
    can :manage, student_manage_authorization
    can :read, student_read_authorization.flatten!
  end

  def manager_manage_authorization
    student_manage_authorization << [Event, EventMajor, GradeCategory, Major,
      Mmo, Partner, Requirement, Transcript, UserEnrollEvent,
      UserEventRequirement, UserLeadEvent, Ckeditor::Asset,
      Ckeditor::AttachmentFile, Ckeditor::Picture, EventRequirement]
  end

  def staff_read_authorization
    staff_manage_authorization << [User, Event]
  end

  def staff_manage_authorization
    student_manage_authorization << [Transcript, GradeCategory, Requirement,
      UserEventRequirement, UserEnrollEvent, EventRequirement]
  end

  def student_read_authorization
    student_manage_authorization << [Event, GradeCategory, Mmo, Partner,
      Transcript, UserEnrollEvent, UserEventRequirement, UserLeadEvent]
  end

  def student_manage_authorization
    [Message, Conversation, Image]
  end
end
