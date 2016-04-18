require "test_helper"

feature "CanAccessExpenseList" do

  scenario "Can add Expenses" do
    visit expense_lists_path
    click_link 'Essensliste'
    click_link 'Ausgabe hinzufügen'
    fill_in('expense_where', :with => "Obi")
    fill_in('expense_when', :with => "23.04.2015")
    fill_in('expense_comment', :with => "Nicht viel gekauft")
    fill_in('expense_expenses_in_euro', :with => 48)
    click_button 'Eintragen'
  end

  scenario "Can edit Expenses" do
    # TODO: Add test
  end

  scenario "Can delete Expenses" do
    # TODO: Add test
  end

end
