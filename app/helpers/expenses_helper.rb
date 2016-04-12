module ExpensesHelper
  def total_expenses_in_expense_list(expense_list)
    expenses = ExpenseList.find(expense_list).expenses
    total = expenses.map {|expense| expense.expenses_in_euro}.reduce(&:+)

    if total.nil?
      0
    else
      total
    end

  end
end
