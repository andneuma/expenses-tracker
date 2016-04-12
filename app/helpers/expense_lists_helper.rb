require 'Date'

module ExpenseListsHelper
  def namify_month(month)
    Date::MONTHNAMES[month]
  end

  def expenses_in_months
    expenses_per_month = Hash[@expense_list.expenses.map {|expense| [expense[:when].month, []]}]

    @expense_list.expenses.each do |expense|
      month_of_expense = expense[:when].month
      expenses_per_month[month_of_expense] << expense
      # debugger
      expenses_per_month[month_of_expense].sort_by! {|e| e[:when]}
    end

    expenses_per_month.sort
  end
end
