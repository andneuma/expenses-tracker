class SetNotificationsEnabledTruePerDefaultInExpenseLists < ActiveRecord::Migration
  def change
    change_column :expense_lists, :notifications_enabled, :boolean, default: true
  end
end
