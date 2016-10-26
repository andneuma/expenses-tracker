class CreateJoinTableTodoUser < ActiveRecord::Migration
  def change
    create_join_table :todos, :users do |t|
      # t.index [:todo_id, :user_id]
      # t.index [:user_id, :todo_id]
    end
  end
end
