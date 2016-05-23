require 'date'

module ExpenseListsHelper
  def expenses_in_year(expenses)
    expenses.group_by { |e| e[:when].strftime('%Y') }.sort
  end

  def expenses_in_months(expenses)
    expenses.group_by { |e| e[:when].month }.sort.map { |month, expense| [Date::MONTHNAMES[month], expense] }
  end

  def expenses_in_current_month
    current_month = Date.today.strftime('%m')
    expenses_in_current_month = Expense.all.select { |e| e.when.strftime('%m') == current_month }
    expenses_in_current_month.map { |e| e.expenses_in_euro }.reduce(&:+)
  end
end
