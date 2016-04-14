require "test_helper"

feature "CanAccessExpenseList" do

  scenario "Add new ExpenseList" do
    visit expense_lists_path
    page.must_have_content "Neue Liste"
    click_link('Neue Liste anlegen')
    assert_equal "/expense_lists/new", page.current_path
    fill_in('expense_list_name', :with => "Lidl")
    fill_in('expense_list_description', :with => "Some descriptionary text with ä and l")
    fill_in('expense_list_budget_in_euro', :with => 23)
    click_on('Eintragen')

    page.must_have_content('Lidl')
  end

  scenario "Can edit ExpenseList" do
    # TODO: Add test
  end

  scenario "Can delete ExpenseList" do
    # TODO: Add test
  end

end
