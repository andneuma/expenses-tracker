class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :where
      t.text :comment
      t.date :when
      t.decimal :expenses_in_euro

      t.timestamps null: false
    end
  end
end
