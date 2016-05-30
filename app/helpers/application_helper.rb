module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when :success
      'alert-success'
    when :error
      'alert-error'
    when :alert
      'alert-block'
    when :notice
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def error_for_form(object, feature)
    object.errors.any? && object.errors[feature].first || ''
  end

  def current_user
    User.find(session[:user_id])
  end

  def user_names
    User.all.map(&:name)
  end

  def user_ids
    User.all.map(&:id)
  end

  # DATE HELPERS
  def month_name(month)
    Date::MONTHNAMES[month]
  end

  def current_month_name
    Date::MONTHNAMES[Date.today.month]
  end

  def current_month
    Date.today.strftime('%m')
  end

  def current_year
    Date.today.strftime('%Y')
  end

  def given_month_is_current_month(month, year)
    month.to_i == current_month.to_i && year.to_i == current_year.to_i
  end

  def simple_date(date)
    date.strftime("%d.%m.%Y")
  end
end
