require 'test_helper'

class HistoryControllerTest < ActionController::TestCase
  test "should get editor" do
    get :editor
    assert_response :success
  end

  test "should get contributor" do
    get :contributor
    assert_response :success
  end

end
