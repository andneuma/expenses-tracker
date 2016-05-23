class ExpenseListsController < ApplicationController
  before_action :require_authentication

  # REST functions
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
    @expense_list = ExpenseList.new(expense_list_params)

    if @expense_list.save
      debugger
      flash[:success] = "Neue Ausgabenliste angelegt: #{@expense_list.name}"
      Notifier.new_expense_list_created("andneuma@posteo.de", @expense_list.name).deliver_now
      render :show
    else
      @errors = @expense_list.errors
      flash[:danger] = "Fehler! Ausgabenliste #{@expense_list.name} konnte nicht angelegt werden"
      render :new
    end
  end

  def edit
    @expense_list = ExpenseList.find(params[:id])
  end

  def update
    @expense_list = ExpenseList.find(params[:id])

    if @expense_list.update(expense_list_params)
      flash[:success] = 'Änderungen erfolgreich übernommen'
      render :show
    else
      @errors = @expense_list.errors
      flash[:danger] = 'Änderungen konnten nicht übernommen werden'
      render :edit
    end
  end

  def destroy
    @expense_list = ExpenseList.find(params[:id])
    expense_list_name = @expense_list.name
    user_email = User.find(session[:user_id]).email

    @expense_list.destroy

    Notifier.expense_list_deleted(user_email, expense_list_name)
    flash[:success] = "Liste wurde erfolgreich gelöscht"

    redirect_to expense_lists_path
  end

  private

  def expense_list_params
    params.require(:expense_list).permit(:name, :description, :budget_in_euro)
  end

  def require_authentication
    unless session[:user_id]
      flash[:danger] = 'Access to this page has been restricted. Please login first!'
      redirect_to login_path
    end
  end
end
