class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      redirect_with_flash :danger, t(".access_denied"),
        redirect_back(fallback_location: root_path)
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name gender code dob phone)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def redirect_with_flash type, msg, url
    flash[type] = msg
    redirect_to url
  end
end
