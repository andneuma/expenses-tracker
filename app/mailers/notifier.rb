class Notifier < ApplicationMailer
  def expense_list_attribute_changes(member, expense_list_after_update, expense_list_before_update)
    @expense_list = expense_list_after_update
    @old_expense_list = expense_list_before_update
    # current_members = @expense_list.members
    mail(to: member, subject: "[Expense list tracker] Ausgabenliste '#{expense_list_before_update.name}' geändert")
  end

  def expense_list_member_signup_notification(new_member, expense_list)
    @expense_list = expense_list
    mail(to: new_member, subject: "[Expense list tracker] Willkommen bei Ausgabenliste '#{expense_list.name}'")
  end

  def expense_list_member_removal_notification(removed_member, expense_list)
    @expense_list = expense_list
    mail(to: removed_member, subject: "[Expense list tracker] Von Ausgabenliste '#{expense_list.name}' gelöscht")
  end

  def expense_list_deleted(member, expense_list)
    @expense_list = expense_list
    mail(to: member, subject: "[Expense list tracker] Ausgabenliste '#{@expense_list.name}' wurde gelöscht")
  end
end
