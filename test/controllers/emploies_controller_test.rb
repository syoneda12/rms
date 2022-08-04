require 'test_helper'

class EmploiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get emploies_index_url
    assert_response :success
  end

  test "should get show" do
    get emploies_show_url
    assert_response :success
  end

  test "should get edit" do
    get emploies_edit_url
    assert_response :success
  end

end
