require 'test_helper'

class PersonalPagesControllerTest < ActionController::TestCase
  test "should get member_page" do
    get :member_page
    assert_response :success
  end

end
