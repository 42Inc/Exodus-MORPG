require 'test_helper'
$permit_registration = true
class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    ServerConfig.first.update_attributes(permit_registration: true)
    get '/users/new'
    assert_no_difference("User.count") do
      $permit_registration = true
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
    ServerConfig.first.update_attributes(permit_registration: true)
    get '/users/new'
      user_params =  { user: {
                              name:  "Example User",
                              email: "user@example.com",
                              password:              "password",
                              password_confirmation: "password"
                             }
                      }
      post('/users', params: user_params)
      follow_redirect!
  
    assert is_logged_in?
  end

end
