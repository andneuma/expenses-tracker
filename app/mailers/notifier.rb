class Notifier < ApplicationMailer
  def expense_list_attribute_changes(user, expense_list_after_update, expense_list_before_update)
    @expense_list = expense_list_after_update
    @old_expense_list = expense_list_before_update
    # current_members = @expense_list.members
    mail(to: user, subject: "[Expense list tracker] Ausgabenliste '#{expense_list_before_update.name}' geändert")
  end

  def new_expense_list_created(user, expense_list)
    @expense_list = expense_list
    mail(to: user, subject: "[Expense list tracker] Eine neue Ausgabenliste wurde angelegt!")
  end

  def expense_list_deleted(user, expense_list_name)
    mail(to: user, subject: "[Expense list tracker] Ausgabenliste '#{expense_list_name}' wurde gelöscht")
  end
end
