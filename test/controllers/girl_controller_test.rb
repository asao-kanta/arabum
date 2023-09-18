require "test_helper"

class GirlControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get girl_index_url
    assert_response :success
  end
end
