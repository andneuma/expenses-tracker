class ExpenseList < ActiveRecord::Base
  has_many :expenses
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  def expenses_in_month(month, year)
    expenses = self.expenses.select do |e|
      e.when.strftime('%m').to_i == month.to_i && e.when.strftime('%Y').to_i == year.to_i
    end
  end

  def sum_of_exp_in_month(month, year)
    expenses = expenses_in_month(self, month, year)
    expenses.map(&:expenses_in_euro).reduce(&:+).to_i || 0
  end

  def euros_left_in_month(month, year)
    budget = self.budget_in_euro
    budget - sum_of_exp_in_month(month, year) if budget
  end

  def expenses_in_month(month, year)
    expenses = self.expenses.select do |e|
      e.when.strftime('%m').to_i == month.to_i && e.when.strftime('%Y').to_i == year.to_i
    end
    expenses
  end

  def sum_of_exp_in_month(month, year)
    expenses = expenses_in_month(month, year)
    expenses.map(&:expenses_in_euro).reduce(&:+).to_i || 0
  end

  def euros_left_in_month(month, year)
    budget = self.budget_in_euro
    budget - sum_of_exp_in_month(month, year) if budget
  end
end
