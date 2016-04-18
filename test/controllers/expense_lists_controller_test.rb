require 'test_helper'

class ExpenseListsControllerTest < ActionController::TestCase

# GET => 'get' (index, show)
# POST => 'post' (new)
# PUT => 'put' (update)

  def setup
    @expense_list = expense_lists :Essensliste
  end

  # INDEX
  test "should get index" do
    get :index
    assert_response :success
  end

  # SHOW
  test "should get show" do
    get :show, id: @expense_list.id
    assert_response :success
  end

  # UPDATE
  test "should get edit" do
    get :edit, id: @expense_list.id
    assert_response :success
  end

  test "should update valid changes" do
    put :update, id: @expense_list.id, expense_list: {name: "Blubber", description: "lalala"}
    assert_response :success
    assert_template 'expense_lists/show'
  end

  test "should not update invalid changes to given expense list" do
    put :update, id: @expense_list.id, expense_list: {name: "", description: "andere Beschreibung"}
    @expense_list.reload.description
    assert "Hier nehmen wir alle Essenseinkaufe auf" == @expense_list.description
  end

  # CREATE
  test "should add new valid expense list" do
    assert_difference 'ExpenseList.count', +1 do
      post :create, expense_list: {name: "Blubber", description: "lalala", budget_in_euro: 23}
    end
  end

  test "should not add invalid expense list" do
    assert_no_difference 'ExpenseList.count' do
      post :create, expense_list: {description: "lalala", budget_in_euro: 23}
    end
  end

  # DESTROY
  test "should delete" do
    assert_difference 'ExpenseList.count', -1 do
      delete :destroy, id:@expense_list.id
    end
    assert_redirected_to expense_lists_path
  end
end
