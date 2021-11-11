require "test_helper"

class EncoderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get encoder_index_url
    assert_response :success
  end
end
