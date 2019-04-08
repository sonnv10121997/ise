class Ability
  include CanCan::Ability

  def initialize(user)
    if user.Admin?
      dashboard_rules
      can %i(read update create), User
    elsif user.Manager?
      dashboard_rules
      manager_rules user.id
    elsif user.Staff?
      dashboard_rules
      staff_rules user.id
    else
      student_rules user.id
    end
  end

  private

  def dashboard_rules
    can :access, :rails_admin
    can :dashboard, :all
  end

  def manager_rules user_id
    can :manage, staff_read_authorization.flatten!
    can :update, User
    cannot :update, User, type: User.types.keys.first
    can :check_requirement, UserEventRequirement
    can :update, UserEnrollEvent
    can :read, manager_read_authorization.flatten!
    manage_message user_id
  end

  def staff_rules user_id
    can :manage, staff_manage_authorization
    can :update, Event
    can :check_requirement, UserEventRequirement
    can :update, UserEnrollEvent
    can :read, manager_read_authorization.flatten!
    can :update, User, id: user_id
    manage_message user_id
  end

  def student_rules user_id
    can :read, :all
    can :show, User, id: user_id
    can :upload_image, UserEventRequirement, user_id: user_id
    can :create, UserEnrollEvent
    manage_message user_id
  end

  def manager_read_authorization
    staff_read_authorization << [User]
  end

  def staff_read_authorization
    staff_manage_authorization << [Event, Mmo, Partner, Major]
  end

  def staff_manage_authorization
    [Transcript, Requirement]
  end

  def manage_message user_id
    can %i(create destroy), Message, user_id: user_id
    can :create, Conversation, sender_id: user_id
    can :create, Conversation, receiver_id: user_id
  end
end
