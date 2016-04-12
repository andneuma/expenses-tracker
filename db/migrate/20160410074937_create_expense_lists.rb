class CreateExpenseLists < ActiveRecord::Migration
  def change
    create_table :expense_lists do |t|
      t.string :name
      t.text :description
      t.decimal :budget_in_euro

      t.timestamps null: false
    end
  end
end
