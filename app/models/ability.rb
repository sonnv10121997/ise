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
      staff_rules
    else
      student_rules
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
    can :read, :all
  end

  def student_rules
    can :manage, student_manage_authorization
    can :read, student_read_authorization.flatten!
    can :read, Student, id: user.id
  end

  def manager_manage_authorization
    student_manage_authorization << [Event, EventMajor, Grade, Major, Mmo,
      Partner, Requirement, Transcript, UserEnrollEvent, UserEventRequirement,
      UserLeadEvent, Ckeditor::Asset, Ckeditor::AttachmentFile, Ckeditor::Picture]
  end

  def staff_manage_authorization
    student_manage_authorization << [Transcript, Grade, Requirement,
      UserEventRequirement, UserEnrollEvent]
  end

  def student_read_authorization
    student_manage_authorization << [Event, Grade, Mmo, Partner, Transcript,
      UserEnrollEvent, UserEventRequirement, UserFollowEvent, UserLeadEvent]
  end

  def student_manage_authorization
    [Message, Conversation, UserFollowEvent]
  end
end
