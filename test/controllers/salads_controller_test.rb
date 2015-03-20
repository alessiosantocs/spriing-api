require 'test_helper'

class SaladsControllerTest < ActionController::TestCase
  setup do
    @salad = salads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salad" do
    assert_difference('Salad.count') do
      post :create, salad: { name: @salad.name }
    end

    assert_redirected_to salad_path(assigns(:salad))
  end

  test "should show salad" do
    get :show, id: @salad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @salad
    assert_response :success
  end

  test "should update salad" do
    patch :update, id: @salad, salad: { name: @salad.name }
    assert_redirected_to salad_path(assigns(:salad))
  end

  test "should destroy salad" do
    assert_difference('Salad.count', -1) do
      delete :destroy, id: @salad
    end

    assert_redirected_to salads_path
  end
end
