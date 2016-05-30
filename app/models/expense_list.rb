class ExpenseList < ActiveRecord::Base
  has_many :expenses
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  before_destroy :notify_about_list_removal
  after_save :notify_about_list_creation

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
    expenses.select do |e|
      e.when.strftime('%m').to_i == month.to_i && e.when.strftime('%Y').to_i == year.to_i
    end
  end

  def sum_of_exp_in_month(month, year)
    expenses_in_month(month, year).map(&:expenses_in_euro).reduce(&:+).to_i || 0
  end

  def euros_left_in_month(month, year)
    budget_in_euro - sum_of_exp_in_month(month, year) if budget_in_euro
  end

  def total_expenses_in_list
    total = expenses.map(&:expenses_in_euro).reduce(&:+)
    total.nil? && 0 || total
  end

  def expenses_in_list_by_user
    expenses.group_by(&:user_id)
  end
end
