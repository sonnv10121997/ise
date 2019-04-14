module ApplicationHelper
  def check_noty_type type
    noty_types = %w(alert success warning error info)

    noty_types.each do |noty_type|
      return type if type == noty_type
    end
    noty_types[0]
  end

  def user_image_for user, css_class
    return fa_icon "user-circle" unless user.avatar&.file?
    image_tag user.avatar.file_url, class: css_class
  end

  def rescue_body_class
    devise_controller? ? "" : "content #{cookies[:sidebarCollapse]}"
  end
end
