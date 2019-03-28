RailsAdmin.config do |config|
  config.parent_controller = ApplicationController.name
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    history_index
    history_show
  end

  models = [Conversation.name, Message.name, UserEventRequirement.name].freeze

  models.each do |model|
    config.model model do
      visible false
    end
  end

  config.model Event do
    edit do
      include_all_fields
      field :description, :ck_editor
      exclude_fields :slug, :user_enroll_events, :event_requirements,
        :event_majors, :user_lead_events, :participants
    end
  end

  config.model User do
    create do
      user_fields
    end

    update do
      user_fields
      exclude_fields :password
      exclude_fields :password_confirmation
    end
  end

  User.types.keys.each do |type|
    config.model type do
      create do
        user_fields
      end

      update do
        user_fields
        exclude_fields :password
        exclude_fields :password_confirmation
      end
    end
  end

  config.model Requirement do
    edit do
      include_fields :name, :description
    end
  end

  config.model Partner do
    edit do
      include_all_fields
      exclude_fields :slug
    end
  end

  config.model Major do
    edit do
      include_all_fields
      exclude_fields :event_majors
    end
  end

  private

  def user_fields
    include_fields :name, :gender, :dob, :code, :phone, :type, :email,
      :password, :password_confirmation, :confirmed_at
  end
end
