require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @expense_list = expense_lists :Essensliste
    @expense = expenses :expensive
  end

  # # TODO: Edit routing to redirect to 'expense_list#show'
  # # bad fix => redirect in index controller
  # test "should get index" do
  #   get :index, expense_list_id: @expense_list.id
  #   assert_response :missing
  # end

  # UPDATE
  test "should get edit for given expense" do
    get :edit, expense_list_id: @expense_list.id, id: @expense.id
    assert_response :success
  end

  test "should update valid changes to given expense" do
    put :update, expense_list_id: @expense_list.id, id: @expense.id, expense: {where: "Aldi", when: "1954-04-23", expenses_in_euro: 23, comment: "adasdasd"}
    @expense.reload.where
    assert_equal "Aldi", @expense.where
    assert_redirected_to expense_list_path(@expense_list)
  end

  test "should not update invalid changes to given expense" do
    put :update, expense_list_id: @expense_list.id, id: @expense.id, expense: {when: "1954-04-23", expenses_in_euro: 238, comment: "adasdasd"}
    @expense.reload.where
    assert "Kaisers" == @expense.where
  end

  # CREATE
  test "should add valid new expense" do
    assert_difference 'Expense.count' do
      post :create, expense_list_id: @expense_list.id, expense: {where: "Aldi", when: "1954-04-23", expenses_in_euro: 23, comment: "adasdasd"}
    end
    assert_redirected_to expense_list_path(@expense_list)
  end

  test "should not add invalid new expense" do
    assert_no_difference 'Expense.count' do
      post :create, expense_list_id: @expense_list.id, expense: {where: "Aldi", expenses_in_euro: 23, comment: "adasdasd"}
    end
  end

  # DESTROY
  test "should delete given expense" do
    assert_difference 'Expense.count', -1 do
      delete :destroy, expense_list_id: @expense_list.id, id: @expense.id
    end
    assert_redirected_to expense_list_path(@expense_list)

  end

end
