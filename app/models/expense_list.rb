class ExpenseList < ActiveRecord::Base
  has_many :expenses, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  before_destroy :notify_about_list_removal if Rails.env == 'production'
  after_save :notify_about_list_creation if Rails.env == 'production'

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

  # VIRTUAL ATTRIBUTES
  def expenses_in_month(month, year)
    expenses.created_in_year(year).created_in_month(month)
  end

  def sum_of_exp_in_month(month, year)
    expenses_in_month(month, year).sum(:expenses_in_euro) || 0
  end

  def euros_left_in_month(month, year)
    budget_in_euro - sum_of_exp_in_month(month, year) if budget_in_euro
  end

  def total_expenses_in_list
    total = expenses.sum(:expenses_in_euro)
    total ? 0 : total
  end

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
