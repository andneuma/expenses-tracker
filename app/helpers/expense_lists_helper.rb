require 'date'

module ExpenseListsHelper
  def expenses_by_year(expenses)
    expenses.group_by { |e| e[:when].strftime('%Y') }.sort
  end

  def expenses_by_months(expenses)
    expenses.group_by { |e| e[:when].month }.sort.map { |month, expense| [Date::MONTHNAMES[month], expense] }
  end

  def expenses_in_month(expense_list, month)
    expenses = expense_list.expenses.select { |e| e.when.strftime('%m') == month }
    expenses.map(&:expenses_in_euro).reduce(&:+) || 0
  end

  def euros_left_in_month(expense_list, month)
    budget = expense_list.budget_in_euro
    budget - expenses_in_month(expense_list, month) if budget
  end
end
