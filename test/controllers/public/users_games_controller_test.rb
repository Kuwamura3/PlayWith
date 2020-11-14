require 'test_helper'

class Public::UsersGamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_users_games_index_url
    assert_response :success
  end

  test "should get create" do
    get public_users_games_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_users_games_destroy_url
    assert_response :success
  end

end
