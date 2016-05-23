class Expense < ActiveRecord::Base
  CASH_DESK = %w{bar konto}

  belongs_to :expense_list
  belongs_to :user

  validates :where, presence: true
  validates_date :when, on_or_before: -> { Date.current }
  validates_presence_of :expenses_in_euro
  validates_numericality_of :expenses_in_euro, greater_than: 0

  validates :when, presence: true
end
