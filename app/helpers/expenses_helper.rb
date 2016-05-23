module ExpensesHelper
  def total_expenses_in_expense_list(expense_list)
    expenses = ExpenseList.find(expense_list).expenses
    total = expenses.map { |expense| expense.expenses_in_euro }.reduce(&:+)
    total.nil? && 0 || total
  end

  def sum_expenses_collection(expense_collection)
    total = expense_collection.map { |expense| expense.expenses_in_euro }.reduce(&:+)
    total.nil? && 0 || total
  end

end
