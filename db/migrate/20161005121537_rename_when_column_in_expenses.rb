class RenameWhenColumnInExpenses < ActiveRecord::Migration
  def change
    remove_column :expenses, :when
    add_column :expenses, :expense_date, :datetime
  end
end
