require 'test_helper'

class OperationalSurveysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get operational_surveys_index_url
    assert_response :success
  end

  test "should get new" do
    get operational_surveys_new_url
    assert_response :success
  end

  test "should get create" do
    get operational_surveys_create_url
    assert_response :success
  end

end
