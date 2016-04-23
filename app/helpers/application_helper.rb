module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def error_for_form(object, feature)
    object.errors.any? && object.errors[feature].first || ""
  end

  def current_user
    User.find(session[:user_id])
  end

  def user_names
    User.all.map { |user| user.name }
  end

  def user_ids
    User.all.map { |user| user.id }
  end
end
