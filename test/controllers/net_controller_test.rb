require 'test_helper'

class NetControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
