require 'test_helper'

class DefaultVolumesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @default_volume = default_volumes(:one)
  end

  test "should get index" do
    get default_volumes_url
    assert_response :success
  end

  test "should get new" do
    get new_default_volume_url
    assert_response :success
  end

  test "should create default_volume" do
    assert_difference('DefaultVolume.count') do
      post default_volumes_url, params: { default_volume: { name: @default_volume.name, volume: @default_volume.volume } }
    end

    assert_redirected_to default_volume_url(DefaultVolume.last)
  end

  test "should show default_volume" do
    get default_volume_url(@default_volume)
    assert_response :success
  end

  test "should get edit" do
    get edit_default_volume_url(@default_volume)
    assert_response :success
  end

  test "should update default_volume" do
    patch default_volume_url(@default_volume), params: { default_volume: { name: @default_volume.name, volume: @default_volume.volume } }
    assert_redirected_to default_volume_url(@default_volume)
  end

  test "should destroy default_volume" do
    assert_difference('DefaultVolume.count', -1) do
      delete default_volume_url(@default_volume)
    end

    assert_redirected_to default_volumes_url
  end
end
