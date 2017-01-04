require 'test_helper'

class ReceiptProductsControllerTest < ActionController::TestCase
  setup do
    @receipt_product = receipt_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:receipt_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create receipt_product" do
    assert_difference('ReceiptProduct.count') do
      post :create, receipt_product: { ,: @receipt_product.,, count_fact: @receipt_product.count_fact, count_plan: @receipt_product.count_plan, product: @receipt_product.product, receipt_id: @receipt_product.receipt_id }
    end

    assert_redirected_to receipt_product_path(assigns(:receipt_product))
  end

  test "should show receipt_product" do
    get :show, id: @receipt_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @receipt_product
    assert_response :success
  end

  test "should update receipt_product" do
    patch :update, id: @receipt_product, receipt_product: { ,: @receipt_product.,, count_fact: @receipt_product.count_fact, count_plan: @receipt_product.count_plan, product: @receipt_product.product, receipt_id: @receipt_product.receipt_id }
    assert_redirected_to receipt_product_path(assigns(:receipt_product))
  end

  test "should destroy receipt_product" do
    assert_difference('ReceiptProduct.count', -1) do
      delete :destroy, id: @receipt_product
    end

    assert_redirected_to receipt_products_path
  end
end
