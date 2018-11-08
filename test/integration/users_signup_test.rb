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

end
