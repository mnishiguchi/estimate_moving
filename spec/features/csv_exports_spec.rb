require 'rails_helper'

RSpec.describe HouseholdItemsController, type: :controller do

  context "non-logged-in user" do

    # Create a user.
    let!(:user)   { FactoryGirl.create(:user) }

    # Create items on the other user.
    let!(:moving) do
      moving = FactoryGirl.create(:user).movings.create(FactoryGirl.attributes_for(:moving))
      5.times do
        moving.household_items.create(FactoryGirl.attributes_for(:household_item))
      end

      return moving
    end

    describe "GET /movings/:moving_id/household_items" do
      before { get :index, moving_id: moving.id, format: "csv" }

      it { expect(response.headers["Content-Type"]).not_to include "application/csv" }
    end
  end

  context "logged-in user" do

    # Create a user.
    let!(:user)   { FactoryGirl.create(:user) }

    # Log that user in.
    login_user # Defined in `spec/support/controller_macros.rb`

    # Create items on that user.
    let!(:moving) do
      moving = subject.current_user.movings.create(FactoryGirl.attributes_for(:moving))
      5.times do
        moving.household_items.create(FactoryGirl.attributes_for(:household_item))
      end

      return moving
    end

    describe "GET /movings/:moving_id/household_items" do

      # render_views

      before { get :index, moving_id: moving.id, format: "csv" }

      it { expect(response.headers["Content-Type"]).to include "application/csv" }

      attributes = %w(name volume quantity volume_subtotal description)

      attributes.each do |field|
        it "has column name - #{field}" do
          expect(response.body).to include field
        end
      end

      attributes.each do |field|
        it "has correct value for #{field}" do
          expect(response.body).to include moving.household_items.first[field].to_s
        end
      end

      it "has correct number of rows" do
        num_of_rows = 1 + moving.household_items.count
        expect(response.body.split(/\n/).size).to eq num_of_rows
      end
    end
  end
end
