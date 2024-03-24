require "test_helper"

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get request" do
    get web_auth_request_url
    assert_response :success
  end

  test "should get callback" do
    get web_auth_callback_url
    assert_response :success
  end
end
