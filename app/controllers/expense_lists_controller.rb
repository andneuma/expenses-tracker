class ExpenseListsController < ApplicationController
  before_action :require_authentication
  before_action :get_expense_list, only: [:show, :edit, :update, :destroy]

  # REST functions
  def index
    @expense_lists = ExpenseList.all
  end

  def new
    @expense_list = ExpenseList.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @expenses = @expense_list.expenses_in_list_by_year_month
    respond_to do |format|
      format.html
      format.csv { send_data @expense_list.to_csv,
        filename: "#{@expense_list.name} (#{@expense_list.created_at.strftime("%d.%m.%Y")} - #{Date.today.strftime("%d.%m.%Y")}).csv" }
    end
  end

  def create
    @expense_list = ExpenseList.new(expense_list_params)
    if @expense_list.save
      respond_to do |format|
        format.html do
          flash[:success] = "Neue Ausgabenliste angelegt: #{@expense_list.name}"
          render :show
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          @errors = @expense_list.errors
          flash[:danger] = "Fehler! Ausgabenliste #{@expense_list.name} konnte nicht angelegt werden"
          render :new
        end
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @expense_list.update(expense_list_params)
      respond_to do |format|
        format.js
        format.html do
          flash[:success] = 'Änderungen erfolgreich übernommen'
          render :show
        end
      end
    else
      @errors = @expense_list.errors
      flash[:danger] = 'Änderungen konnten nicht übernommen werden'
      render :edit
    end
  end

  def destroy
    @expense_list.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'List deleted'
        redirect_to expense_lists_path
      end
      format.js
    end
  end

  private

  def get_expense_list
    @expense_list = ExpenseList.find(params[:id])
  end

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
