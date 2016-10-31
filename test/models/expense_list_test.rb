require "test_helper"

class ExpenseListTest < ActiveSupport::TestCase
  # TODO: Move this to factories
  def setup
    @expense_list = ExpenseList.create(name: 'List with budget', budget_in_euro: 100)
    @expense_list.update(created_at: "2013-10-01 00:00:00 UTC")

    3.times.with_index do |i|
      User.create(name: 'Testuser' + i.to_s, password_digest: 'secret')
    end

    expense_dates = [
      '2013-10-02',
      '2013-10-05',
      '2013-11-13',
      '2013-12-12',
      '2014-01-02']

    5.times do
      @expense_list.expenses.create(expenses_in_euro: 50,
                                    where: 'Grocery store',
                                    cash_desk: 'Cash',
                                    user_id: User.pluck(:id).sample,
                                    expense_date: expense_dates.pop)
    end
  end

  # Test basic accounting stuff
  test "Calculate total expenses in list correctly" do
    assert_equal 250, @expense_list.total_expenses_in_list
  end

  test "Calculate months between given dates correctly" do
    assert_equal 1, @expense_list.months_between('2013-10-01'.to_date, '2013-11-30'.to_date)
  end

  test "Calculate total account balance over one month correctly" do
    assert_equal 0, @expense_list.account_balance_between('2013-10-01'.to_date, '2013-10-31'.to_date)
  end

  test "Calculate total account balance over several months correctly" do
    assert_equal 100, @expense_list.account_balance_between('2013-10-01'.to_date, '2013-12-31'.to_date)
  end

  test "Calculate total account balance over two years correctly" do
    assert_equal 150, @expense_list.account_balance_between('2013-10-01'.to_date, '2014-01-31'.to_date)
  end

  test "Calculate monthly totals correctly" do
    assert_equal 100, @expense_list.sum_of_expenses_in_month(10, 2013)
  end

  test "Calculate yearly totals correctly" do
    assert_equal 200, @expense_list.sum_of_expenses_in_year(2013)
  end
end
