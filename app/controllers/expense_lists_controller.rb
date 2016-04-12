class ExpenseListsController < ApplicationController
  def index
    @expense_lists = ExpenseList.all
  end

  def new
    @expense_list = ExpenseList.new
  end

  def show
    @expense_list = ExpenseList.find(params[:id])
    @expenses = @expense_list.expenses
  end

  def create
    # TODO: Implement error handling
    @expense_list = ExpenseList.new(expense_list_params)

    if @expense_list.save
      flash[:success] = "Jo, hat jeklappt!"
      # redirect_to expense_list_path(@expense_list)
      render :show
    else
      render :new
    end
  end

  def edit
    @expense_list = ExpenseList.find(params[:id])
  end

  def update
    @expense_list = ExpenseList.find(params[:id])

    if @expense_list.update(expense_list_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    ExpenseList.find(params[:id]).destroy
    redirect_to expense_lists_path
  end

  private
  def expense_list_params
    params.require(:expense_list).permit(:name, :description, :budget_in_euro)
  end
end
