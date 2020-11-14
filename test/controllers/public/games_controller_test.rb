require 'test_helper'

class Public::GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get public_games_top_url
    assert_response :success
  end

  test "should get about" do
    get public_games_about_url
    assert_response :success
  end

  test "should get search" do
    get public_games_search_url
    assert_response :success
  end

  test "should get index" do
    get public_games_index_url
    assert_response :success
  end

  test "should get create" do
    get public_games_create_url
    assert_response :success
  end

  test "should get new" do
    get public_games_new_url
    assert_response :success
  end

end
