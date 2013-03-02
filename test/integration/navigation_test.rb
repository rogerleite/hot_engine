require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest

  test "List engines and mount hello_engine" do
    get "/engines"
    assert_response :success

    assert_raise(ActionController::RoutingError) {
      get "/hello_world"
    }

    he_mount_path = hot_engine.mount_path(:name => "hello_engine", :at => "hello_world")
    he_unmount_path = hot_engine.unmount_path(:name => "hello_engine")

    # mount
    get he_mount_path
    assert_redirected_to hot_engine.root_path

    get "/hello_world"
    assert_response :success

    # unmount
    get he_unmount_path
    assert_redirected_to hot_engine.root_path

    assert_raise(ActionController::RoutingError) {
      get "/hello_world"
    }
  end

end

