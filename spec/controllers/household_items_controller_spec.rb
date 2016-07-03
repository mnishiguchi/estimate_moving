require 'rails_helper'

RSpec.describe HouseholdItemsController, type: :controller do

  context "non-logged-in user" do

    before :each do
      user = FactoryGirl.create(:user)
      @moving = user.movings.create(FactoryGirl.attributes_for(:moving))
      5.times do
        @moving.household_items.create(FactoryGirl.attributes_for(:household_item))
      end
    end

    # INDEX
    describe "GET /movings/:moving_id/household_items" do
      it "redirects to the login page" do
        get :index, moving_id: @moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    # NEW
    describe "GET /movings/:moving_id/household_items/new" do
      it "redirects to the login page" do
        get :new, moving_id: @moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    # CREATE
    describe "POST /movings/:moving_id/household_items" do
      let(:household_item_params) { FactoryGirl.attributes_for(:household_item) }

      it "does not change the HouseholdItem count" do
        expect{
          post :create, moving_id: @moving.id, household_item: household_item_params
        }.not_to change(HouseholdItem, :count)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    # EDIT
    describe "GET /movings/:moving_id/household_items/:id/edit" do
      it "redirects to the login page" do
        id = @moving.household_items.first.id
        get :edit, moving_id: @moving.id, id: id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    # UPDATE
    describe "PATCH /movings/:moving_id/household_items/:id" do
      let(:household_item_params) { FactoryGirl.attributes_for(:household_item) }

      it "redirects to the login page" do
        id = @moving.household_items.first.id
        patch :update, moving_id: @moving.id, id: id, household_item: household_item_params
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    # DESTROY
    describe "DELETE /movings/:moving_id/household_items/:id" do
      it "redirects to the login page" do
        id = @moving.household_items.first.id
        delete :destroy, moving_id: @moving.id, id: id
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  # ===

  context "logged-in user, accessing his/her own item" do
    let!(:user)   { FactoryGirl.create(:user) }  # A current user
    login_user # Defined in `spec/support/controller_macros.rb`

    before :each do
      @moving = subject.current_user.movings.create(FactoryGirl.attributes_for(:moving))
      5.times do
        @moving.household_items.create(FactoryGirl.attributes_for(:household_item))
      end
    end

    # INDEX
    describe "GET /movings/:moving_id/household_items" do
      before :each do
        get :index, moving_id: @moving.id
      end
      it { expect(response).to render_template(:index) }
    end

    # NEW
    describe "GET /movings/:moving_id/household_items/new" do
      before :each do
        get :new, moving_id: @moving.id
      end
      it { expect(response).to render_template(:new) }
    end

    # CREATE
    describe "POST /movings/:moving_id/household_items" do
      let(:household_item_params) { FactoryGirl.attributes_for(:household_item) }

      it "increments the HouseholdItem count, then redirects to the show page" do
        expect{
          post :create, moving_id: @moving.id, household_item: household_item_params
        }.to change(HouseholdItem, :count).by(1)
      end
    end

    # EDIT
    describe "GET /movings/:moving_id/household_items/:id/edit" do
      before :each do
        id = @moving.household_items.first.id
        get :edit, moving_id: @moving.id, id: id
      end

      it { expect(response).to render_template(:edit) }
    end

    # UPDATE
    describe "PATCH /movings/:moving_id/household_items/:id" do
      let!(:household_item_params) do
        household_item_params = FactoryGirl.attributes_for(:household_item)
        household_item_params[:name]        = "floor lamp"
        household_item_params[:description] = "breakable treat with care!"
        household_item_params
      end

      before :each do
        @household_item = @moving.household_items.first
        patch :update, moving_id: @moving.id, id: @household_item.id, household_item: household_item_params
      end

      specify do
        expect(@household_item.reload.name).to eq household_item_params[:name]
        expect(@household_item.reload.description).to eq household_item_params[:description]
      end
    end

    # DESTROY
    describe "DELETE /movings/:moving_id/household_items/:id" do
      before(:each) do
        user = subject.current_user
        moving = user.movings.create(FactoryGirl.attributes_for(:moving))
      end
      it "decrements the HouseholdItem count, then redirects to the movings page" do
        expect{
          id = @moving.household_items.first.id
          delete :destroy, moving_id: @moving.id, id: id
        }.to change(HouseholdItem, :count).by(-1)
      end
    end
  end
end
