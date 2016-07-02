require 'rails_helper'

RSpec.describe MovingsController, type: :controller do

  context "non-logged-in user" do

    before :each do
      user = FactoryGirl.create(:user)
      @moving = user.movings.create(FactoryGirl.attributes_for(:moving))
    end

    describe "GET #index" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "GET #show" do
      it "redirects to the login page" do
        get :show, id: @moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "GET #new" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "POST #create" do
      let(:moving_params) { FactoryGirl.attributes_for(:moving) }

      it "does not change the Moving count, redirecting to the login page" do
        expect{
          post :create, moving: moving_params
        }.not_to change(Moving, :count)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "GET #edit" do
      it "redirects to the login page" do
        get :edit, id: @moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "PATCH #update" do
      let(:moving_params) { FactoryGirl.attributes_for(:moving) }

      it "redirects to the login page" do
        patch :update, id: @moving.id, moving: moving_params
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the login page" do
        delete :destroy, id: @moving.id
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  # ===

  context "logged-in user accessing the current user's own moving" do
    let!(:user)   { FactoryGirl.create(:user) }  # A current user
    login_user # Defined in `spec/support/controller_macros.rb`

    describe "GET #index" do
      before(:each) { get :index }
      it { is_expected.to render_template(:index) }
    end

    describe "GET #show" do
      before(:each) do
        user = subject.current_user
        moving = user.movings.create(FactoryGirl.attributes_for(:moving))
        get :show, id: moving.id
      end
      it { is_expected.to render_template :show }
    end

    describe "GET #new" do
      subject { get :new }
      it { is_expected.to render_template(:new) }
    end

    describe "POST #create" do
      it "increments the Moving count, then redirects to the show page" do
        expect{
          user = subject.current_user
          moving = user.movings.create(FactoryGirl.attributes_for(:moving))
        }.to change(Moving, :count).by(1)
      end
    end

    describe "GET #edit" do
      before(:each) do
        user = subject.current_user
        @moving = user.movings.create(FactoryGirl.attributes_for(:moving))
        get :edit, id: @moving.id
      end
      it { is_expected.to render_template(:edit) }
    end

    describe "POST #update" do
      let(:moving_params) do
        moving_params = FactoryGirl.attributes_for(:moving)
        moving_params[:name]        = "new name"
        moving_params[:description] = "new description"
        moving_params
      end

      before(:each) do
        user = subject.current_user
        @moving = user.movings.create(FactoryGirl.attributes_for(:moving))
        patch :update, id: @moving.id, moving: moving_params
      end

      specify do
        expect(@moving.reload.name).to eq moving_params[:name]
        expect(@moving.reload.description).to eq moving_params[:description]
      end
    end

    describe "DELETE #destroy" do
      before(:each) do
        user = subject.current_user
        moving = user.movings.create(FactoryGirl.attributes_for(:moving))
      end
      it "decrements the moving count, then redirects to the movings page" do
        expect{
          moving = subject.current_user.movings.first
          delete :destroy, id: moving.id
        }.to change(Moving, :count).by(-1)
      end
    end
  end
end
