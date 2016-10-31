ExpenseList.destroy_all
Expense.destroy_all
User.destroy_all

# Add users
User.create(name: 'andi',
            email: 'admin@test.com',
            password: 'secret',
            password_confirmation: 'secret')

User.create(name: 'daniela',
            email: 'user@test.com',
            password: 'secret',
            password_confirmation: 'secret')

# Add 3 expense_lists
ExpenseList.create(
  name: 'List1',
  description: 'This is test list 1',
  budget_in_euro: 500
)

ExpenseList.create(
  name: 'List2',
  description: 'This is test list 2',
  budget_in_euro: 1000
)

ExpenseList.create(
  name: 'List3',
  description: 'This is test list 3'
)

# Add random expenses
def sample_dates_for_each_month(years = 1)
  sample = []
  start_date = "01/2014".to_date.beginning_of_year
  end_date = (start_date + years.years).to_date.end_of_year
  (start_date..end_date).group_by(&:year).each do |year, dates|
    dates.group_by(&:month).each do |month, dates|
      sample << dates.sample(rand(1..3))
    end
  end
  sample.flatten
end

LOCATIONS = %w{Lidl Aldi LPG Baumarkt Zoohandlung}
CASH_DESK = %w{bar Konto FoodCoop}
user_ids = User.all.map(&:id)
ExpenseList.all.each do |expense_list|
  dates = sample_dates_for_each_month
  dates.count.times do
    Expense.new(
      expense_list_id: expense_list.id,
      where: LOCATIONS.sample,
      comment: '',
      expenses_in_euro: 10 * (0..5).to_a.sample,
      user_id: user_ids.sample,
      cash_desk: CASH_DESK.sample,
      expense_date: dates.pop
    ).save(validate: false)
  end
end
