class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_with_flash :error, t("rails_admin.access_denied")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name gender code dob phone)
  end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options(options = {})
    {locale: I18n.locale}.merge options
  end

  def redirect_with_flash type, msg
    flash[type] = msg
    redirect_to main_app.root_path
  end

  def find_user slug
    @user = User.find_by_slug slug
  end

  def find_event slug
    @event = Event.find_by_slug slug
  end

  def find_user_event slug
    @user_event = Event.find_by_slug slug
  end

  def find_conversation sender, receiver
    @conversation =
      Conversation.between(sender, receiver).first ||
      Conversation.create(sender_id: sender.id, receiver_id: receiver.id)
  end

  def create_notification event = nil, requirement = nil, message = nil, notifier, receiver, noti_type, noty_type
    notification = Notification.create notification_type: noti_type,
      event_id: event&.id, notifier_id: notifier.id, receiver_id: receiver.id,
      requirement_id: requirement&.id, message_id: message&.id
    text = t("notifications.noti_#{notification.notification_type}",
      user: notification.notifier_name, event: notification.event_name,
      requirement: notification.requirement_name, message: notification
      .message_content, time: notification.created_at.strftime(Settings.model
      .notification.datetime_format)).html_safe
    NotificationBroadcastJob.perform_now notification, text, noty_type
  end
end
