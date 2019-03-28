require 'test_helper'

class DrawingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get drawings_new_url
    assert_response :success
  end

  test "should get create" do
    get drawings_create_url
    assert_response :success
  end

end
