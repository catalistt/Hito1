require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get api_news_url
    assert_response :success
  end

  test "should get dates" do
    get api_dates_url
    assert_response :success
  end

end
