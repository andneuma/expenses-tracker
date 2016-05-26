class AddCritThresholdInExpenseLists < ActiveRecord::Migration
  def change
    add_column :expense_lists, :crit_threshold, :decimal, default: 0.15
  end
end
