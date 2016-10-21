# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview

  def expense_list_attribute_changes_preview
    member = expense_list.members.first
    Notifier.expense_list_attribute_changes(member, new_expense_list, old_expense_list)
  end

  def expense_list_member_signup_notification_preview
    Notifier.expense_list_member_signup_notification('andneuma@posteo.de', new_expense_list)
  end

  def expense_list_member_removal_notification_preview
    Notifier.expense_list_member_removal_notification('andneuma@posteo.de', new_expense_list)
  end

  private

  def new_expense_list
    ExpenseList.new(name: 'Schushu',
                    members: ['Jesus@bibeltv.de', 'andneuma@posteo.de'],
                    budget_in_euro: 23,
                    description: 'afoijogijer')
  end

  def old_expense_list
    ExpenseList.new(name: 'Blubber',
                    members: ['Jesus@bibeltv.de', 'andneuma@posteo.de'],
                    description: 'afoijogijer')
  end
end
