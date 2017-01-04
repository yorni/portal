require 'test_helper'

class SendAccountingsControllerTest < ActionController::TestCase
  setup do
    @send_accounting = send_accountings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:send_accountings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create send_accounting" do
    assert_difference('SendAccounting.count') do
      post :create, send_accounting: {  }
    end

    assert_redirected_to send_accounting_path(assigns(:send_accounting))
  end

  test "should show send_accounting" do
    get :show, id: @send_accounting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @send_accounting
    assert_response :success
  end

  test "should update send_accounting" do
    patch :update, id: @send_accounting, send_accounting: {  }
    assert_redirected_to send_accounting_path(assigns(:send_accounting))
  end

  test "should destroy send_accounting" do
    assert_difference('SendAccounting.count', -1) do
      delete :destroy, id: @send_accounting
    end

    assert_redirected_to send_accountings_path
  end
end
