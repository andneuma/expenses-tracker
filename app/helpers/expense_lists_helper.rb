require 'date'

module ExpenseListsHelper
  def expenses_by_year(expenses)
    expenses.group_by(&:year).sort
  end

  def expenses_by_months(expenses)
    expenses.group_by(&:month).sort
  end
end
