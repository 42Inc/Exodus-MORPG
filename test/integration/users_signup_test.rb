require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get '/users/new'
    assert_no_difference("User.count") do

      user_params =  { user: {
                              name: "",
                              email: "foo@invalid",
                              password: "foo",
                              password_confirmation: "bar"
                             }
                     }
      post('/users', params: user_params)
    end
  end

  test "valid signup information" do
    get '/users/new'
    assert_difference 'User.count', 1 do
      user_params =  { user: {
                              name:  "Example User",
                              email: "user@example.com",
                              password:              "password",
                              password_confirmation: "password"
                             }
                      }
      post(users_path, params: user_params)
      follow_redirect!
    end
    assert_template 'users/show'
    assert is_logged_in?
  end

end
