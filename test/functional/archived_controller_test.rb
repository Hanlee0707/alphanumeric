require 'test_helper'

class ArchivedControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
