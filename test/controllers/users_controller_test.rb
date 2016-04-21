require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users :Andi
  end

  # Test CRUD

  test "should create valid user" do
    get :new

    assert_difference 'User.count', +1 do
      post :create, user: {name: "Andi",
                          email: "asdwef@poerwg.de",
                          password: "asdasd",
                          password_confirmation: "asdasd"}
    end
  end

  test "should not create invalid user" do
    get :new

    assert_no_difference 'User.count' do
      post :create, user: {name: "Andi",
                          email: "",
                          password: "asdasd",
                          password_confirmation: "asdasd"}
    end
  end

  test "should update valid changes of given user credentials" do
    put :update, id: @user.id, user: {  name: "Peter",
                                        email: "oirjoerg@posteo.de",
                                        password: "asdasd",
                                        password_confirmation: "asdasd" }
    @user.reload.name
    assert_equal "Peter", @user.name
    assert_redirected_to root_path
  end

  test "should not update invalid changes to given user credentials" do
    put :update, id: @user.id, user: {  name: "Peter",
                                        email: "",
                                        password: "asdasd",
                                        password_confirmation: "asdasd" }
    @user.reload.name
    assert_not_equal "Peter", @user.name
    # assert_redirected_to root_path
  end

end
