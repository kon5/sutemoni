require 'test_helper'

class GrMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gr_members_index_url
    assert_response :success
  end

  test "should get show" do
    get gr_members_show_url
    assert_response :success
  end

  test "should get new" do
    get gr_members_new_url
    assert_response :success
  end

  test "should get edit" do
    get gr_members_edit_url
    assert_response :success
  end

end
