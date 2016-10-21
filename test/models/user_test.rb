require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Andi',
                     email: 'asdeerg@potee.de',
                     password: 'asdasfwfe',
                     password_confirmation: 'asdasfwfe')
  end

  test 'valid user should be valid' do
    assert @user.valid?
  end

  test 'invalid user should be invalid' do
    assert_not User.new.valid?
  end

  test 'blank email should not be allowed' do
    changes = @user.dup
    changes.email = ''
    assert_not changes.valid?
  end

  test 'blank name should not be allowed' do
    changes = @user.dup
    changes.name = ''
    assert_not changes.valid?
  end

  test 'too short passwort should not be allowed' do
    changes = @user.dup
    changes.password = 'asd'
    changes.password_confirmation = 'asd'
    assert_not changes.valid?
  end
end
