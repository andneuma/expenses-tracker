class ExpenseList < ActiveRecord::Base
  has_many :expenses
  serialize :members, Array

  def is_valid_email_format?(string)
    string.match /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end

  def members_list=(arg)
    # TODO: Only import valid emails (=> valid email format)
    # `strip` returns a copy of str with leading and trailing whitespace removed.
    self.members = arg.split(',').map {|v| v.strip }. select {|v| is_valid_email_format? v}
  end

  def members_list
    self.members.join(', ')
    # self.members
  end

  validates :name, presence: true
end
