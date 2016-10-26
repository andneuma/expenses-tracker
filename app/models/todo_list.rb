class TodoList < ActiveRecord::Base
  has_many :todos

  def open_todos
    todos.where(finished: false)
  end
end
