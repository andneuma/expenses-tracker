class Expense < ActiveRecord::Base
  CASH_DESK = %w{ bar konto foodcoop }

  belongs_to :expense_list, dependent: :destroy
  # TODO: callback einbauen, dass wenn User gelöscht wird die Ausgabe auf anonymous oder Nil-User (to be implemented) gesetzt wird
  belongs_to :user

  validates :where, presence: true, length: { minimum: 2, maximum: 75 }
  validates_date :expense_date, on_or_before: -> { Date.current }
  validates_presence_of :expenses_in_euro
  validates_numericality_of :expenses_in_euro

  validates :expense_date, presence: true

  after_save :alert_on_critical_budget if Rails.env == 'production'

  # Virtual attributes
  scope :created_in_year, -> (year) { where("date_part('year', expense_date) = ?", year) }
  scope :created_in_month, -> (month) { where("date_part('month', expense_date) = ?", month ) }

  def month
    expense_date.strftime('%m').to_i
  end

  def year
    expense_date.strftime('%Y').to_i
  end

  def alert_on_critical_budget
    return false unless expense_list.budget_in_euro

    current_month = Date.today.strftime('%m').to_i
    current_year = Date.today.strftime('%Y').to_i
    euros_left = expense_list.euros_left_in_month(current_month, current_year)

    if euros_left < expense_list.crit_threshold * expense_list.budget_in_euro
      User.all do |user|
        Notifier.budget_critical(user.email, expense_list).deliver_now
      end
    end
  end
end
