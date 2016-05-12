class AddChashDeskToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :cash_desk, :string
  end
end
