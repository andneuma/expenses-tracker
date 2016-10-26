json.extract! todo, :id, :name, :description, :starts_at, :ends_at, :todo_list_id, :created_at, :updated_at
json.url todo_url(todo, format: :json)