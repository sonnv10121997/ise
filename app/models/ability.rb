class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
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

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
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
    can :read, User, id: user.id
  end

  def manager_manage_authorization
    student_manage_authorization << [Event, EventMajor, Grade, Major, Mmo,
      Partner, Requirement, Transcript, UserEnrollEvent, UserEventRequirement,
      UserLeadEvent, Ckeditor::Asset, Ckeditor::AttachmentFile, Ckeditor::Picture]
  end

  def staff_manage_authorization
    student_manage_authorization << [Transcript, Grade, Requirement,
      UserEventRequirement, UserEnrollEvent,]
  end

  def student_read_authorization
    student_manage_authorization << [Event, Grade, Mmo, Partner, Transcript,
      UserEnrollEvent, UserEventRequirement, UserFollowEvent, UserLeadEvent]
  end

  def student_manage_authorization
    [Comment, UserFollowEvent]
  end
end
