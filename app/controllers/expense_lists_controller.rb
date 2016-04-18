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
    @expense_list.save
    @errors = @expense_list.errors

    unless @errors.any?
      flash[:success] = "Neue Ausgabenliste angelegt: #{@expense_list.name}"
      render :show
    else
      flash[:danger] ="Fehler! Ausgabenliste #{@expense_list.name} konnte nicht angelegt werden"
      render :new
    end
  end

  def edit
    @expense_list = ExpenseList.find(params[:id])
  end

  def update
    @expense_list = ExpenseList.find(params[:id])
    @expense_list.update(expense_list_params)
    @errors = @expense_list.errors

    unless @errors.any?
      flash[:success] = "Änderungen erfolgreich übernommen"
      render :show
    else
      flash[:danger] = "Änderungen konnten nicht übernommen werden"
      render :edit
    end
  end

  def destroy
    ExpenseList.find(params[:id]).destroy

    flash[:success] = "Liste wurde erfolgreich gelöscht"

    redirect_to expense_lists_path
  end

  private
  def expense_list_params
    params.require(:expense_list).permit(:name, :description, :budget_in_euro, :members_list)
  end
end
