require 'date'

module ExpenseListsHelper
  def namify_month(month)
    # MONTHNAMES_GER = [nil, "Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"]
    Date::MONTHNAMES[month]
  end

  def expenses_in_year(expenses)
    expenses.group_by {|e| e[:when].strftime("%y")}
  end

  def expenses_in_months(expenses)
    expenses.group_by {|e| e[:when].strftime("%m")}

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
