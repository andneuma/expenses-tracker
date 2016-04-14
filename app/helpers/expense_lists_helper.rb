require 'date'

module ExpenseListsHelper
  def expenses_in_year(expenses)
    expenses.group_by {|e| e[:when].strftime("%Y")}.sort
  end

  def expenses_in_months(expenses)
    expenses.group_by {|e| e[:when].month}.sort.map {|month, expense| [Date::MONTHNAMES[month],expense]}

    # expenses_per_month = Hash[expenses.map {|expense| [expense[:when].month, []]}]
    #
    # @expense_list.expenses.each do |expense|
    #   month_of_expense = expense[:when].month
    #   expenses_per_month[month_of_expense] << expense
    #   expenses_per_month[month_of_expense].sort_by! {|e| e[:when]}
    # end
    #
    # expenses_per_month.sort
  end
end
