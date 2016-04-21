class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
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
end
