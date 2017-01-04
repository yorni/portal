require 'test_helper'

class SoProductsControllerTest < ActionController::TestCase
  setup do
    @so_product = so_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:so_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create so_product" do
    assert_difference('SoProduct.count') do
      post :create, so_product: { contract_id: @so_product.contract_id, count: @so_product.count, date: @so_product.date, institution_id: @so_product.institution_id, product_id: @so_product.product_id }
    end

    assert_redirected_to so_product_path(assigns(:so_product))
  end

  test "should show so_product" do
    get :show, id: @so_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @so_product
    assert_response :success
  end

  test "should update so_product" do
    patch :update, id: @so_product, so_product: { contract_id: @so_product.contract_id, count: @so_product.count, date: @so_product.date, institution_id: @so_product.institution_id, product_id: @so_product.product_id }
    assert_redirected_to so_product_path(assigns(:so_product))
  end

  test "should destroy so_product" do
    assert_difference('SoProduct.count', -1) do
      delete :destroy, id: @so_product
    end

    assert_redirected_to so_products_path
  end
end
