class ExpensesController < ApplicationController
  before_action :require_authentication

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
      flash[:success] = 'Neue Ausgabe erfolgreich angelegt'
      redirect_to expense_list_path(@expense_list)
    else
      @errors = @expense.errors
      flash[:danger] = 'Ausgabe konnte nicht angelegt werden'
      render :new
    end
  end

  def edit
    @expense_list = ExpenseList.find(params[:expense_list_id])
    @expense = @expense_list.expenses.find(params[:id])
  end

  def update
    @expense_list = ExpenseList.find(params[:expense_list_id])
    @expense = @expense_list.expenses.find(params[:id])

    if @expense.update(expense_params)
      flash[:success] = 'Änderungen erfolgreich übernommen'
      redirect_to expense_list_path(@expense_list)
    else
      @errors = @expense.errors
      flash[:danger] = 'Änderungen konnten nicht übernommen werden'
      render :edit
    end
  end

  def destroy
    @expense_list = ExpenseList.find(params[:expense_list_id])
    @expense_list.expenses.find(params[:id]).destroy

    flash[:success] = 'Ausgabe erfolgreich gelöscht'

    redirect_to expense_list_path(@expense_list)
  end

  private

  def expense_params
    params.require(:expense).permit(:where, :expense_date, :comment, :expenses_in_euro, :user_id, :cash_desk)
  end

  def require_authentication
    unless session[:user_id]
      flash[:danger] = 'Access to this page has been restricted. Please login first!'
      redirect_to login_path
    end
  end
end
