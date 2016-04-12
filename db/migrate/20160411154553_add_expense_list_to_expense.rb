class AddExpenseListToExpense < ActiveRecord::Migration
  def change
    add_reference :expenses, :expense_list, index: true, foreign_key: true
  end
end
