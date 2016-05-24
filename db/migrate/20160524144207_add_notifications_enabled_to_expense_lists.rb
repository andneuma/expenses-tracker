class AddNotificationsEnabledToExpenseLists < ActiveRecord::Migration
  def change
    add_column :expense_lists, :notifications_enabled, :boolean
  end
end
