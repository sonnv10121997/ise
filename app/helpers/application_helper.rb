module ApplicationHelper
  def check_noty_type type
    noty_types = %w(alert success warning error info)

    noty_types.each do |noty_type|
      return type if type == noty_type
    end
    noty_types[0]
  end
end
