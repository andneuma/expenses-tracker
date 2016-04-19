class ExpenseListsController < ApplicationController
  # helper_method :notify_members_about_their_status_after_update

  def notify_members_about_their_status_after_update(expense_list, members_before_update = [])
    members_after_update = expense_list.members
    removed_members = members_before_update.which_elements_not_in members_after_update
    new_members = members_after_update.which_elements_not_in members_before_update

    removed_members.each do |removed_member|
      Notifier.expense_list_member_removal_notification(removed_member, expense_list).deliver_now
    end

    new_members.each do |new_member|
      Notifier.expense_list_member_signup_notification(new_member, expense_list).deliver_now
    end
  end

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
    # TODO: Implement error handling
    @expense_list = ExpenseList.new(expense_list_params)
    @expense_list.save
    @errors = @expense_list.errors

    if @errors.any?
      flash[:danger] = "Fehler! Ausgabenliste #{@expense_list.name} konnte nicht angelegt werden"
      render :new
    else
      flash[:success] = "Neue Ausgabenliste angelegt: #{@expense_list.name}"
      notify_members_about_their_status_after_update @expense_list
      render :show
    end
  end

  def edit
    @expense_list = ExpenseList.find(params[:id])
  end

  def update
    @expense_list = ExpenseList.find(params[:id])
    @old_expense_list = @expense_list
    @expense_list.update(expense_list_params)

    current_members = @expense_list.members
    @errors = @expense_list.errors

    if @errors.any?
      flash[:danger] = "Änderungen konnten nicht übernommen werden"
      render :edit
    else
      flash[:success] = "Änderungen erfolgreich übernommen"
      notify_members_about_their_status_after_update(@expense_list, @old_expense_list.members)

      current_members.each do |member|
        Notifier.expense_list_attribute_changes(member, @expense_list, @old_expense_list).deliver_now
      end

      render :show
    end
  end

  def destroy
    @expense_list = ExpenseList.find(params[:id])
    members = @expense_list.members
    members.each { |member| Notifier.expense_list_deleted(member, @expense_list).deliver_now}
    @expense_list.destroy

    flash[:success] = "Liste wurde erfolgreich gelöscht"

    redirect_to expense_lists_path
  end

  private

  def expense_list_params
    params.require(:expense_list).permit(:name, :description, :budget_in_euro, :members_list)
  end
end
