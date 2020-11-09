require 'test_helper'

class Public::UsersCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_users_comments_create_url
    assert_response :success
  end

end
