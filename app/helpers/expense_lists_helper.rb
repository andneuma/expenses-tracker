require 'date'

module ExpenseListsHelper
  def expenses_by_year(expenses)
    expenses.group_by { |e| e[:when].strftime('%Y') }.sort
  end

  def expenses_by_months(expenses)
    expenses.group_by { |e| e[:when].month }.sort.map { |month, expense| [month, expense] }
  end

  def expenses_in_month(expense_list, month, year)
    expenses = expense_list.expenses.select do |e|
      e.when.strftime('%m').to_i == month.to_i && e.when.strftime('%Y').to_i == year.to_i
    end
    expenses
  end

  def sum_of_exp_in_month(expense_list, month, year)
    expenses = expenses_in_month(expense_list, month, year)
    expenses.map(&:expenses_in_euro).reduce(&:+).to_i || 0
  end

  def euros_left_in_month(expense_list, month, year)
    budget = expense_list.budget_in_euro
    budget - sum_of_exp_in_month(expense_list, month, year) if budget
  end

  def given_month_is_current_month(month, year)
    month.to_i == current_month.to_i && year.to_i == current_year.to_i
  end
end
