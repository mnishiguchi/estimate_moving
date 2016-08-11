require 'test_helper'

class HouseholdItemsControllerTest < ActionDispatch::IntegrationTest

  def setup
    user = create(:user)
    @moving = user.movings.create(attributes_for(:moving))
    5.times { @moving.household_items.create(attributes_for(:household_item)) }
  end

  # NOTE: Only logged-in user can access HouseholdItems therefore in this test
  # all attempts result in redirects to the user sign up page.

  test "GET /movings/:id/household_items" do
    get moving_household_items_url(@moving)
    assert_redirected_to "/users/sign_in"
  end

  test "GET /movings/:id/household_items/new" do
    get new_moving_household_item_url(@moving)
    assert_redirected_to "/users/sign_in"
  end

  test "POST /movings/:id/household_items/" do
    assert_no_difference('HouseholdItem.count') do
      post moving_household_items_url(@moving),
        params: attributes_for(:household_item)
    end

    assert_redirected_to "/users/sign_in"
  end

  test "GET /movings/:id/household_items/:id/edit" do
    get edit_moving_household_item_url(@moving, @moving.household_items.first)
    assert_redirected_to "/users/sign_in"
  end

  test "PATCH /movings/:id/household_items/:id" do
    patch moving_household_item_url(@moving, @moving.household_items.first),
      params: attributes_for(:household_item)

    assert_redirected_to "/users/sign_in"
  end

  test "/movings/:id/household_items/:id" do
    assert_no_difference('HouseholdItem.count') do
      delete moving_household_item_url(@moving, @moving.household_items.first)
    end

    assert_redirected_to "/users/sign_in"
  end

  # #---
  # #---
  #
  # context "logged-in user, accessing his/her own item" do
  #
  #   # Create a user and log him/her in.
  #   let!(:user)   { create(:user) }
  #   login_user # Defined in `spec/support/controller_macros.rb`
  #
  #   # Create items on that user.
  #   let!(:moving) do
  #     moving = subject.current_user.movings.create(attributes_for(:moving))
  #     5.times do
  #       moving.household_items.create(attributes_for(:household_item))
  #     end
  #
  #     return moving
  #   end
  #
  #   # INDEX
  #   describe "GET /movings/:moving_id/household_items" do
  #     before(:each) { get :index, moving_id: moving.id }
  #
  #     it { expect(response).to render_template(:index) }
  #   end
  #
  #   # NEW
  #   describe "GET /movings/:moving_id/household_items/new" do
  #     before(:each) { get :new, moving_id: moving.id }
  #
  #     it { expect(response).to render_template(:new) }
  #   end
  #
  #   # CREATE
  #   # describe "POST /movings/:moving_id/household_items" do
  #   #   let(:household_item_params) { attributes_for(:household_item) }
  #   #
  #   #   it "increments the HouseholdItem count, then redirects to the show page" do
  #   #     expect{
  #   #       post :create, moving_id: moving.id, household_item: household_item_params
  #   #     }.to change(HouseholdItem, :count).by(1)
  #   #   end
  #   # end
  #
  #   # EDIT
  #   describe "GET /movings/:moving_id/household_items/:id/edit" do
  #     before(:each) do
  #       id = moving.household_items.first.id
  #       get :edit, moving_id: moving.id, id: id
  #     end
  #
  #     it { expect(response).to render_template(:edit) }
  #   end
  #
  #   # UPDATE
  #   describe "PATCH /movings/:moving_id/household_items/:id" do
  #     let!(:household_item_params) do
  #       household_item_params = attributes_for(:household_item)
  #       household_item_params[:name]        = "floor lamp"
  #       household_item_params[:description] = "breakable treat with care!"
  #       household_item_params
  #     end
  #
  #     before(:each) do
  #       @household_item = moving.household_items.first
  #       patch :update, moving_id: moving.id, id: @household_item.id, household_item: household_item_params
  #     end
  #
  #     specify do
  #       expect(@household_item.reload.name).to eq household_item_params[:name]
  #       expect(@household_item.reload.description).to eq household_item_params[:description]
  #     end
  #   end
  #
  #   # DESTROY
  #   # describe "DELETE /movings/:moving_id/household_items/:id" do
  #   #   before(:each) do
  #   #     user = subject.current_user
  #   #     moving = user.movings.create(attributes_for(:moving))
  #   #   end
  #   #
  #   #   it "decrements the HouseholdItem count, then redirects to the movings page" do
  #   #     expect{
  #   #       id = moving.household_items.first.id
  #   #       delete :destroy, moving_id: moving.id, id: id
  #   #     }.to change(HouseholdItem, :count).by(-1)
  #   #   end
  #   # end
  # end
end
