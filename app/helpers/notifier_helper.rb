module NotifierHelper
  def expense_lists_with_notifications_enabled
    ExpenseList.all.select(&:notifications_enabled)
  end
end
