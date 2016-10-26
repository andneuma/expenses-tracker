class Todo < ActiveRecord::Base
  belongs_to :todo_list, dependent: :destroy
  has_and_belongs_to_many :users, dependent: :nullify
<<<<<<< HEAD
  has_many :comments
=======
>>>>>>> e23a701... Add seed data
end
