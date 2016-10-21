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
  budget_in_euro: 2350
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
LOCATIONS = %w{Lidl Aldi LPG Baumarkt Zoohandlung}
CASH_DESK = %w{bar Konto FoodCoop}
user_ids = User.all.map(&:id)
dates = ((Date.today - 365)..Date.today).to_a
ExpenseList.all.each do |expense_list|
  (1..25).to_a.sample.times do
    Expense.new(
      expense_list_id: expense_list.id,
      where: LOCATIONS.sample,
      comment: '',
      expenses_in_euro: (0..200).to_a.sample,
      user_id: user_ids.sample,
      cash_desk: CASH_DESK.sample,
      expense_date: dates.sample
    ).save(validate: false)
  end
end
