require 'test_helper'

class SubordinatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subordinates_index_url
    assert_response :success
  end

  test "should get edit" do
    get subordinates_edit_url
    assert_response :success
  end

  test "should get show" do
    get subordinates_show_url
    assert_response :success
  end

end
