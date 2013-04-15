require 'test_helper'

class PublishedControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
