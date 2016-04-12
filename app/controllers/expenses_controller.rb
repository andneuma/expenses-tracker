class ExpensesController < ApplicationController
  def index
    expense_list = ExpenseList.find(params[:expense_list_id])
    @expenses = expense_list.expenses
  end

  def show
    expense_list = ExpenseList.find(params[:expense_list_id])
    @expense = expense_list.expenses.find(params[:id])
  end

  def new
    @expense_list = ExpenseList.find(params[:expense_list_id])
    @expense = @expense_list.expenses.new
  end

  def create
    @expense_list = ExpenseList.find(params[:expense_list_id])
    @expense = @expense_list.expenses.create(expense_params)

    if @expense.save
      redirect_to expense_list_path(@expense_list)
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:where, :when, :comment, :expenses_in_euro)
  end
end