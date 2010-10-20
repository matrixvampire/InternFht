require "test_helper"
class BasicsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success    
  end
  
  test "should get quotations" do
    get :quotations
    assert_response :success    
  end
  
  test "should get viewsource" do
    get :viewsource
    assert_response :success
  end
  
  test "should get parsing xml" do
    get :parsing_xml
    assert_response :success
  end
end