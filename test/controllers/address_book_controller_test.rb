require 'test_helper'

class AddressBookControllerTest < ActionController::TestCase
  test "should get index_page" do
    get :index_page
    assert_response :success
  end

end
