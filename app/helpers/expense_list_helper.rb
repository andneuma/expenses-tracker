module ExpenseListHelper
  def continous_account_balance_for(expense_list, month, year)
    start_date = expense_list.first_expense.expense_date
    end_date = "#{month}/#{year}".to_date.end_of_month
    expense_list.account_balance_between(start_date, end_date)
  end
end
