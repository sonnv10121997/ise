class Ability
  include CanCan::Ability

  def initialize(user)
    if user.Admin?
      dashboard_rules
      can %i(read update create), User
      manage_message user.id
    elsif user.Manager?
      dashboard_rules
      manager_rules
      manage_message user.id
    elsif user.Staff?
      dashboard_rules
      staff_rules
      can :update, User, id: user.id
      manage_message user.id
    else
      student_rules
      can :read, Student, id: user.id
      manage_message user.id
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
    can :read, manager_manage_authorization.flatten!
  end

  def staff_rules
    can :manage, staff_manage_authorization.flatten!
    can :update, Event
    can :read, manager_manage_authorization.flatten!
  end

  def student_rules
    can :manage, student_manage_authorization
    can :read, student_read_authorization.flatten!
  end

  def manager_manage_authorization
    staff_read_authorization << [Ckeditor::Asset,
      Ckeditor::AttachmentFile, Ckeditor::Picture, EventRequirement]
  end

  def staff_read_authorization
    student_read_authorization << [User]
  end

  def staff_manage_authorization
    student_manage_authorization << [Transcript, GradeCategory, Requirement,
      UserEnrollEvent, EventRequirement]
  end

  def student_read_authorization
    student_manage_authorization << [Event, GradeCategory, Mmo, Partner,
      Transcript, UserEnrollEvent, UserLeadEvent, Requirement, Major, EventMajor,
      UserEventRequirement]
  end

  def student_manage_authorization
    [Image]
  end

  def manage_message user_id
    can :manage, Message, user_id: user_id
    can :manage, Conversation, sender_id: user_id, receiver_id: user_id
  end
end
