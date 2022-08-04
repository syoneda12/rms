require 'test_helper'

class EmploysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employs_index_url
    assert_response :success
  end

  test "should get show" do
    get employs_show_url
    assert_response :success
  end

  test "should get edit" do
    get employs_edit_url
    assert_response :success
  end

end
