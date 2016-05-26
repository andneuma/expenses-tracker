class Expense < ActiveRecord::Base
  CASH_DESK = %w{ bar konto foodcoop }

  belongs_to :expense_list
  belongs_to :user

  validates :where, presence: true, length: {minimum: 2, maximum: 75}
  validates_date :when, on_or_before: -> { Date.current }
  validates_presence_of :expenses_in_euro
  validates_numericality_of :expenses_in_euro, greater_than: 0

  validates :when, presence: true

  after_save :alert_on_critical_budget

  def alert_on_critical_budget
    return false unless expense_list.budget_in_euro
    budget = expense_list.budget_in_euro
    thresh = expense_list.crit_threshold
    curr_month = Date.today.strftime('%m').to_i
    curr_year = Date.today.strftime('%Y').to_i

    if expense_list.euros_left_in_month(curr_month, curr_year) < thresh * budget
      User.all do |user|
        Notifier.budget_critical(user.email, expense_list).deliver_now
      end
    end
  end
end
