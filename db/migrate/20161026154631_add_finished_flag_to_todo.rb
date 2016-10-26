class AddFinishedFlagToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :finished, :boolean, default: false
  end
end
