class Expense < ActiveRecord::Base
  belongs_to :expense_list

  validates :where, presence: true
  validates :expenses_in_euro, presence: true
  validates_date :when, on_or_before: -> { Date.current }
  validates_numericality_of :expenses_in_euro, :greater_than => 0

  validates :when, presence: true
end