desc 'weekly digest'
task weekly_digest: :environment do
  users_emails = User.all.map(&:email)
  expense_lists = ExpenseList.all.select(&:notifications_enabled)
  users_emails.each do |email_address|
    expense_lists.each do |expense_list|
      Notifier.weekly_digest(email_address, expense_list).deliver_now
    end
  end
end
