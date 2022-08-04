require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organizations_index_url
    assert_response :success
  end

  test "should get edit" do
    get organizations_edit_url
    assert_response :success
  end

  test "should get update" do
    get organizations_update_url
    assert_response :success
  end

end
