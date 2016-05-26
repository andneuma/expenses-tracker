class Notifier < ApplicationMailer
  helper :application
  helper :expense_lists

  def expense_list_attribute_changes(user, expense_list_after_update, expense_list_before_update)
    @expense_list = expense_list_after_update
    @old_expense_list = expense_list_before_update
    mail(to: user, subject: "[Expense list tracker] Ausgabenliste '#{expense_list_before_update.name}' geändert")
  end

  def new_expense_list_created(user, expense_list)
    @expense_list = expense_list
    mail(to: user, subject: '[Expense list tracker] Eine neue Ausgabenliste wurde angelegt!')
  end

  def expense_list_deleted(user, expense_list_name)
    mail(to: user, subject: "[Expense list tracker] Ausgabenliste '#{expense_list_name}' wurde gelöscht")
  end

  def budget_critical(user, expense_list)
    @expense_list = expense_list
    mail(to: user, subject: "[Expense list tracker] Critical expense level in '#{expense_list.name}'!")
  end

  def weekly_digest(user)
    mail(to: user, subject: '[Expense list tracker] Weekly digest')
  end
end
