class ExpenseList < ActiveRecord::Base
  has_many :expenses
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  before_destroy :notify_about_list_removal
  after_save :notify_about_list_creation
  after_update :notify_about_list_changes

  # MAILER CALLBACK FUNCTIONS
  def notify_about_list_changes
    User.all.each do |user|
      Notifier.expense_list_attribute_changes(user.email, self).deliver_now
    end
  end

  def notify_about_list_creation
    User.all.each do |user|
      Notifier.new_expense_list_created(user.email, self).deliver_now
    end
  end

  def notify_about_list_removal
    User.all.each do |user|
      Notifier.expense_list_deleted(user.email, name).deliver_now
    end
  end

  # VIRTUAL ATTRIBUTES
  def sum_of_exp_in_month(month, year)
    expenses = expenses_in_month(self, month, year)
    expenses.map(&:expenses_in_euro).reduce(&:+).to_i || 0
  end

  def euros_left_in_month(month, year)
    budget = budget_in_euro
    budget - sum_of_exp_in_month(month, year) if budget
  end

  def expenses_in_month(month, year)
    expenses = expenses.select do |e|
      e.when.strftime('%m').to_i == month.to_i && e.when.strftime('%Y').to_i == year.to_i
    end
    expenses
  end
end
