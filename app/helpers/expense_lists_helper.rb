module ExpenseListsHelper
  def monthly_expenses_list
    expenses = @expense_list.expenses
    @months = expenses.map {|expense| expense[:when].month }.uniq
    # a = expenses.map do |expense|
  end
end
