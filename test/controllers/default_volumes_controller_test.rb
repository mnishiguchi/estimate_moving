require 'test_helper'

class DefaultVolumesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @default_volume = FactoryGirl.create(:default_volume)
  end

  # NOTE: Only admin user can access DefaultVolumes therefore in this test
  # all attempts result in redirects to the admin sign up page

  test "should get index" do
    get default_volumes_url
    assert_redirected_to "/admins/sign_in"
  end

  test "should get new" do
    get new_default_volume_url
    assert_redirected_to "/admins/sign_in"
  end

  test "should create default_volume" do
    assert_no_difference('DefaultVolume.count') do
      post default_volumes_url,
        params: {
          default_volume: {
            name:   "Takoyaki",
            volume: 8
          }
        }
    end
    assert_redirected_to "/admins/sign_in"
  end

  test "should show default_volume" do
    get default_volume_url(@default_volume)
    assert_redirected_to "/admins/sign_in"
  end

  test "should get edit" do
    get edit_default_volume_url(@default_volume)
    assert_redirected_to "/admins/sign_in"
  end

  test "should update default_volume" do
    patch default_volume_url(@default_volume),
      params: {
        default_volume: {
          name:   @default_volume.name,
          volume: @default_volume.volume
        }
      }
    assert_redirected_to "/admins/sign_in"
  end

  test "should destroy default_volume" do
    assert_no_difference('DefaultVolume.count') do
      delete default_volume_url(@default_volume)
    end

    assert_redirected_to "/admins/sign_in"
  end
end
