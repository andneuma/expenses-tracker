module UsersHelper
  def unapproved_users
    return User.all.select {|user| user.role == "Unapproved"}
  end

  def users
    User.all
  end
end
