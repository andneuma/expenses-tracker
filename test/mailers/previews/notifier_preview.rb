# Preview all emails at http://localhost:3000/rails/mailers/notifier
class NotifierPreview < ActionMailer::Preview

  def expense_list_attribute_changes_preview
    old_expense_list = ExpenseList.new(name: "Blubber", members: ["Jesus@bibeltv.de", "andneuma@posteo.de"], description: "afoijogijer")
    expense_list = ExpenseList.new(name: "Schushu",
                                    members: ["Jesus@bibeltv.de","andneuma@posteo.de"],
                                    budget_in_euro: 23,
                                    description: "afoijogijer")
    Notifier.expense_list_attribute_changes(expense_list.members.first, expense_list, old_expense_list)
  end

  def expense_list_member_signup_notification_preview
    expense_list = ExpenseList.new(name: "Schushu",
                                    members: ["Jesus@bibeltv.de","andneuma@posteo.de"],
                                    budget_in_euro: 23,
                                    description: "afoijogijer")
    Notifier.expense_list_member_signup_notification("andneuma@posteo.de", expense_list)
  end

  def expense_list_member_removal_notification_preview
    expense_list = ExpenseList.new(name: "Schushu",
                                    members: ["Jesus@bibeltv.de","andneuma@posteo.de"],
                                    budget_in_euro: 23,
                                    description: "afoijogijer")
    Notifier.expense_list_member_removal_notification("andneuma@posteo.de", expense_list)
  end
end
