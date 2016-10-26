User.destroy_all
ExpenseList.destroy_all
Expense.destroy_all

# Add users
User.create(name: 'andi',
            email: 'admin@test.com',
            password: 'secret',
            password_confirmation: 'secret')

User.create(name: 'daniela',
            email: 'user@test.com',
            password: 'secret',
            password_confirmation: 'secret')



# EXPENSE LIST SEED DATA

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

# TODO LIST SEED DATA

TodoList.destroy_all
Todo.destroy_all

TodoList.create(name: "First List", description: "This is a seed todo list")
TodoList.create(name: "Second List", description: "This is another seed todo list")

user_ids = User.pluck(:id)
dates = ((Date.today - 365)..Date.today).to_a
TodoList.all.each do |todo_list|
  (1..10).to_a.sample.times do
    sample_date = dates.sample
    todo = Todo.create(
      todo_list_id: todo_list.id,
      description: Faker::Hacker.say_something_smart,
      name: Faker::Company.bs,
      starts_at: sample_date,
      ends_at: sample_date + 2)
    todo.users = User.where(id: user_ids.sample(rand(1..User.count)))
  end
end
