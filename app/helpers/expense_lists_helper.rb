require 'date'

module ExpenseListsHelper
  def expenses_in_year(expenses)
    expenses.group_by {|e| e[:when].strftime("%Y")}.sort
  end

  def expenses_in_months(expenses)
    expenses.group_by {|e| e[:when].month}.sort.map {|month, expense| [Date::MONTHNAMES[month],expense]}
  end

end
