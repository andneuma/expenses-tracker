class ExpenseList < ActiveRecord::Base
  has_many :expenses, -> { order(expense_date: 'asc') }, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  before_destroy :notify_about_list_removal if Rails.env == 'production'
  after_save :notify_about_list_creation if Rails.env == 'production'

  def budget_in_euro
    self[:budget_in_euro].to_i if self[:budget_in_euro]
  end

  # EXPORT TO CSV
  def to_csv
    attributes = %w{where when expenses_in_euro cash_desk }

    CSV.generate(headers: true) do |csv|
      csv << attributes

      expenses.all.each do |expense|
        csv << attributes.map { |attr| expense.send(attr) }
      end
    end
  end

  # MAILER CALLBACK FUNCTIONS
  def notify_about_list_creation
    User.all.each do |user|
      Notifier.new_expense_list_created(user.email, self).deliver_now
    end
  end

  def notify_about_list_removal
    User.all.each do |user|
      Notifier.expense_list_deleted(user.email, self).deliver_now
    end
  end

  ### LIST EXPENSES METHODS

  ## DATE related stuff
  def months_between(start_date, end_date)
    (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
  end

  def latest_expense
    expenses.order(expense_date: 'asc').last
  end

  def first_expense
    expenses.order(expense_date: 'asc').first
  end

  ## LIST EXPENSES - AR Relations
  def expenses_in_month(month, year)
    start_date = "#{month}/#{year}".to_date.beginning_of_month
    end_date = start_date.end_of_month
    expenses_between(start_date, end_date)
  end

  def expenses_in_year(year)
    start_date = "01/#{year}".to_date.beginning_of_year
    end_date = start_date.end_of_year
    expenses_between(start_date, end_date)
  end

  def expenses_between(start_date, end_date)
    expenses.where("expense_date BETWEEN ? AND ?", start_date, end_date)
  end

  ## LIST EXPENSES - absolute values
  def total_expenses_in_list
    total = expenses.sum(:expenses_in_euro)
    total ? total.to_i : 0
  end

  def total_account_balance
    return unless budget_in_euro
    start_date = created_at.to_date
    end_date = latest_expense.expense_date
    account_balance_between(start_date, end_date)
  end

  def sum_of_expenses_between(start_date, end_date)
    expenses_between(start_date, end_date).sum(:expenses_in_euro).to_i
  end

  def account_balance_between(start_date, end_date)
    return unless budget_in_euro
    months_in_date_range = months_between(start_date, end_date) + 1
    budget_in_euro * months_in_date_range - sum_of_expenses_between(start_date, end_date)
  end

  def sum_of_expenses_in_year(year)
    expenses_in_year(year).sum(:expenses_in_euro).to_i
  end

  def sum_of_expenses_in_month(month, year)
    expenses_in_month(month, year).sum(:expenses_in_euro).to_i
  end

  def euros_left_in_month(month, year)
    budget_in_euro - sum_of_expenses_in_month(month, year) if budget_in_euro
  end

  ## LIST EXPENSES - grouped

  def expenses_in_list_by_user
    expenses.group_by(&:user_id)
  end

  def expenses_in_list_by_year
    expenses.group_by(&:year)
  end

  def expenses_in_list_by_year_month
    monthly_expenses = {}
    expenses_in_list_by_year.each do |year, expenses|
      monthly_expenses[year] = expenses.group_by(&:month)
    end
    monthly_expenses
  end
end
