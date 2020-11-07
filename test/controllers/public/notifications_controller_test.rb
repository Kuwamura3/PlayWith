require 'test_helper'

class Public::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy_all" do
    get public_notifications_destroy_all_url
    assert_response :success
  end

  test "should get create" do
    get public_notifications_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_notifications_destroy_url
    assert_response :success
  end

end
