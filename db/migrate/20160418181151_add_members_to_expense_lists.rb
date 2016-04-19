class AddMembersToExpenseLists < ActiveRecord::Migration
  def change
    add_column :expense_lists, :members, :text, array: true, default: []
  end
end
