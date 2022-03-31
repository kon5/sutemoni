require 'test_helper'

class MonitorControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get monitor_show_url
    assert_response :success
  end

  test "should get index" do
    get monitor_index_url
    assert_response :success
  end

end
