require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  def setup
    @expense = Expense.new(where: "Lidl", comment: "", when: Time.now, expenses_in_euro: 34.20)
  end

  test "valid expense should be valid" do
    assert @expense.valid?
  end

  test "expense missing 'where' should be invalid" do
    expense_missing_where = Expense.new(where: "", comment: "", when: Time.now, expenses_in_euro: 23.0)
    assert_not expense_missing_where.valid?
  end

  # Date tests
  test "expense missing date of expense should be invalid" do
    expense_missing_when = Expense.new(where: "Lidl", comment: "", when: nil, expenses_in_euro: 23.0)
    assert_not expense_missing_when.valid?
  end

  test "malformatted date of expense should be invalid" do
    expense_when_false_format = Expense.new(where: "Lidl", comment: "", when: "yesterday", expenses_in_euro: 23.0)
    assert_not expense_when_false_format.valid?
  end

  test "future date of expense should be invalid" do
    future_expense = Expense.new(where: "Lidl", comment: "", when: Date.today+1, expenses_in_euro: 23.2)
    assert_not future_expense.valid?
  end

  # Expenses in euro value tests
  test "expense missing expenses value should be invalid" do
    expense_missing_expenses_in_euro = Expense.new(where: "Lidl", comment: "", when: Time.now, expenses_in_euro: nil)
    assert_not expense_missing_expenses_in_euro.valid?
  end

  test "negative expenses value should be invalid" do
    negative_expenses_in_euro = Expense.new(where: "Lidl", comment: "", when: Time.now, expenses_in_euro: -23.5)
    assert_not negative_expenses_in_euro.valid?
  end
end
