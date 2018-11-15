require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:testuser)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    user_params =  { session: {
                               email: "",
                               password: ""
                              }
                   }
    post('/login', params: user_params)
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    user_params =  { session: {
                               email: @user.email,
                               password: "password"
                              }
                    }
    post('/login', params: user_params)
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end
