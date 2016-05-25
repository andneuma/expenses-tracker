desc 'weekly digest'
task weekly_digest: :environment do
  users_emails = User.all.map(&:email)
  expense_list_collection = ExpenseList.all.select(&:notifications_enabled)

  users_emails.each do |email_address|
    Notifier.weekly_digest(email_address).deliver_now
  end
end
