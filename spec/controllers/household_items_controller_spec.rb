require 'rails_helper'

RSpec.describe HouseholdItemsController, type: :controller do

  context "non-logged-in user" do

    let!(:moving) do
      user = create(:user)
      moving = user.movings.create(attributes_for(:moving))
      5.times do
        moving.household_items.create(attributes_for(:household_item))
      end

      moving
    end

    # INDEX
    describe "GET /movings/:moving_id/household_items" do
      subject { get :index, moving_id: moving.id }

      it { is_expected.to redirect_to "/users/sign_in" }
    end

    # NEW
    describe "GET /movings/:moving_id/household_items/new" do
      subject { get :new, moving_id: moving.id }

      it { is_expected.to redirect_to "/users/sign_in" }
    end

    # CREATE
    describe "POST /movings/:moving_id/household_items" do
      let(:household_item_params) { attributes_for(:household_item) }

      subject do
        lambda { post :create, moving_id:      moving.id,
                               household_item: household_item_params
        }
      end

      it {
        is_expected.not_to change(HouseholdItem, :count)
        is_expected.to redirect_to "/users/sign_in"
      }
    end

    # EDIT
    describe "GET /movings/:moving_id/household_items/:id/edit" do

      subject do
        get :edit, moving_id: moving.id,
                   id:        moving.household_items.first.id
      end

      it { is_expected.to redirect_to "/users/sign_in" }
    end

    # UPDATE
    describe "PATCH /movings/:moving_id/household_items/:id" do
      let(:household_item_params) { attributes_for(:household_item) }

      subject do
        id = moving.household_items.first.id
        patch :update, moving_id:      moving.id,
                       id:             moving.household_items.first.id,
                       household_item: household_item_params
      end

      it { is_expected.to redirect_to "/users/sign_in" }
    end

    # DESTROY
    describe "DELETE /movings/:moving_id/household_items/:id" do

      subject do
        delete :destroy, moving_id: moving.id,
                         id:        moving.household_items.first.id
      end

      it { is_expected.to redirect_to "/users/sign_in" }
    end
  end

  #---
  #---

  context "logged-in user, accessing his/her own item" do

    # Create a user and log him/her in.
    let!(:user)   { create(:user) }
    login_user # Defined in `spec/support/controller_macros.rb`

    # Create items on that user.
    let!(:moving) do
      moving = subject.current_user.movings.create(attributes_for(:moving))
      5.times do
        moving.household_items.create(attributes_for(:household_item))
      end

      return moving
    end

    # INDEX
    describe "GET /movings/:moving_id/household_items" do
      before(:each) { get :index, moving_id: moving.id }

      it { expect(response).to render_template(:index) }
    end

    # NEW
    describe "GET /movings/:moving_id/household_items/new" do
      before(:each) { get :new, moving_id: moving.id }

      it { expect(response).to render_template(:new) }
    end

    # CREATE
    # describe "POST /movings/:moving_id/household_items" do
    #   let(:household_item_params) { attributes_for(:household_item) }
    #
    #   it "increments the HouseholdItem count, then redirects to the show page" do
    #     expect{
    #       post :create, moving_id: moving.id, household_item: household_item_params
    #     }.to change(HouseholdItem, :count).by(1)
    #   end
    # end

    # EDIT
    describe "GET /movings/:moving_id/household_items/:id/edit" do
      before(:each) do
        id = moving.household_items.first.id
        get :edit, moving_id: moving.id, id: id
      end

      it { expect(response).to render_template(:edit) }
    end

    # UPDATE
    describe "PATCH /movings/:moving_id/household_items/:id" do
      let!(:household_item_params) do
        household_item_params = attributes_for(:household_item)
        household_item_params[:name]        = "floor lamp"
        household_item_params[:description] = "breakable treat with care!"
        household_item_params
      end

      before(:each) do
        @household_item = moving.household_items.first
        patch :update, moving_id: moving.id, id: @household_item.id, household_item: household_item_params
      end

      specify do
        expect(@household_item.reload.name).to eq household_item_params[:name]
        expect(@household_item.reload.description).to eq household_item_params[:description]
      end
    end

    # DESTROY
    # describe "DELETE /movings/:moving_id/household_items/:id" do
    #   before(:each) do
    #     user = subject.current_user
    #     moving = user.movings.create(attributes_for(:moving))
    #   end
    #
    #   it "decrements the HouseholdItem count, then redirects to the movings page" do
    #     expect{
    #       id = moving.household_items.first.id
    #       delete :destroy, moving_id: moving.id, id: id
    #     }.to change(HouseholdItem, :count).by(-1)
    #   end
    # end
  end
end
