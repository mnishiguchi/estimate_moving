class HouseholdItemsController < ApplicationController
  before_action :authenticate_user!      # All actions
  before_action :set_current_user_moving # All actions
  before_action :set_household_item, only: [:edit, :update, :destroy]

  # To use the `item_volume_json` and `json_for_pie_chart` helpers.
  include HouseholdItemsHelper

  # Show all the items of a moving project that belongs to current user.
  def index
    # Create data that is required for the bar chart.
    @data = json_for_bar_chart(@moving)
  end

  def new
    @household_item = @moving.household_items.new
  end

  def create
    @household_item = @moving.household_items.new(household_item_params.merge(moving: @moving))
    if @household_item.save
      flash[:success] = "Item created"
      redirect_to new_moving_household_item_url @moving
    else
      # flash.now[:danger] = @household_item.errors.full_messages.to_sentence
      flash.now[:danger] = "Your changes were not saved. Check out the problems below."
      render :new
    end
  end

  def edit
  end

  def update
    if @household_item.update(household_item_params)
      flash[:success] = "Item updated"
      redirect_to @moving
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        @household_item.destroy
        flash.now[:success] = "Item deleted"
        # Create data that is required for the bar chart.
        @data = json_for_bar_chart(@moving)
      end
    end
  end

  private

    def household_item_params
      accessible = [:name, :volume, :quantity, :all_tags, :description, :moving_id]
      params.require(:household_item).permit(accessible)
    end

    # Make sure that we access movings through current_user.
    def set_current_user_moving
      @moving = current_user.movings.find(params[:moving_id])
    end

    # Make sure that we access household_items through current_user.
    def set_household_item
      @household_item = @moving.household_items.find(params[:id])
    end

    # # Prepares data for moving stats partial.
    # def set_data_for_stats
    #   # NOTE: Items must be retrieved via @moving.
    #   @household_items ||= @moving.household_items
    #
    #   # Create data that is required for the bar chart.
    #   @data = json_for_bar_chart(@moving)
    # end
end
