require 'rails_helper'

RSpec.describe MovingsController, type: :controller do

  context "non-logged-in user" do

    let(:user) { FactoryGirl.create(:user) }
    let(:moving) { user.movings.create(FactoryGirl.attributes_for(:moving)) }

    # INDEX
    describe "GET /movings" do
      subject { get :index }

      it { is_expected.to redirect_to "/users/sign_in" }
    end

    #  NEW
    describe "GET /movings/new" do
      subject { get :new }

      it { is_expected.to redirect_to "/users/sign_in" }
    end

    # CREATE
    describe "POST /movings" do
      let(:moving_params) { FactoryGirl.attributes_for(:moving) }

      it "does not change the Moving count, redirecting to the login page" do
        expect{
          post :create, moving: moving_params
        }.not_to change(Moving, :count)

        expect(response).to redirect_to "/users/sign_in"
      end
    end

    # EDIT
    describe "GET /movings/:id/edit" do
      subject { get :edit, id: moving.id }

      it { is_expected.to redirect_to "/users/sign_in" }
    end

    # UPDATE
    describe "PATCH /movings/:id" do
      let(:moving_params) { FactoryGirl.attributes_for(:moving) }

      it "redirects to the login page" do
        patch :update, id: moving.id, moving: moving_params
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    # DESTROY
    describe "DELETE /movings/:id" do
      subject { delete :destroy, id: moving.id }

      it { is_expected.to redirect_to "/users/sign_in" }
    end
  end

  # ===

  context "logged-in user accessing his/her own moving" do

    # https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)
    login_user

    let(:user) { subject.current_user }
    let(:moving) { user.movings.create(FactoryGirl.attributes_for(:moving)) }

    # INDEX
    describe "GET /movings" do
      subject { get :index }

      it { is_expected.to render_template(:index) }
    end

    #  NEW
    describe "GET /movings/new" do
      subject { get :new }

      it { is_expected.to render_template(:new) }
    end

    # CREATE
    describe "POST /movings" do
      it "increments the Moving count" do
        expect{
          user.movings.create(FactoryGirl.attributes_for(:moving))
        }.to change(Moving, :count).by(1)
      end
    end

    # EDIT
    describe "GET /movings/:id/edit" do
      before(:each) { get :edit, id: moving.id }

      it { expect(response).to render_template(:edit) }
    end

    # UPDATE
    describe "PATCH /movings/:id" do
      let(:moving_params) do
        moving_params = FactoryGirl.attributes_for(:moving)
        moving_params[:name]        = "new name"
        moving_params[:description] = "new description"
        moving_params
      end

      before(:each) { patch :update, id: moving.id, moving: moving_params }

      specify do
        expect(moving.reload.name).to eq moving_params[:name]
        expect(moving.reload.description).to eq moving_params[:description]
      end
    end

    # DESTROY
    describe "DELETE /movings/:id" do
      before(:each) do
        user.movings.create(FactoryGirl.attributes_for(:moving))
      end
      it "decrements the moving count" do
        expect{
          delete :destroy, id: user.movings.first.id
        }.to change(Moving, :count).by(-1)
      end
    end
  end
end
