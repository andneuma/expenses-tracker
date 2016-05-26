require 'date'

module ExpenseListsHelper
  def expenses_by_year(expenses)
    expenses.group_by { |e| e[:when].strftime('%Y') }.sort
  end

  def expenses_by_months(expenses)
    expenses.group_by { |e| e[:when].month }.sort.map { |month, expense| [month, expense] }
  end
end
