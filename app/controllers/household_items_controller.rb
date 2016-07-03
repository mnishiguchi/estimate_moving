class HouseholdItemsController < ApplicationController
  before_action :authenticate_user!      # All actions
  before_action :set_current_user_moving # All actions
  before_action :set_household_item, only: [:edit, :update, :destroy]

  # Show all the items of a moving project that belongs to current user.
  # If requested, perform the specified filtering.
  def index
    # if params[:filter].present?
    #   @household_items = HouseholdItem.tagged_with(params[:filter], params[:moving_id])
    # else
    #   @household_items = @moving.household_items
    # end

    respond_to do |format|
      format.html do
        @household_items = @moving.household_items
        render :index
      end
      format.js do
        if params[:filter].present?
          @household_items = HouseholdItem.tagged_with(params[:filter], params[:moving_id])
        else
          @household_items = @moving.household_items
        end
      end
    end
  end

  def new
    @household_item = @moving.household_items.new
  end

  # The add form is in movings#show.
  def create
    @household_item = @moving.household_items.new(household_item_params
                                                  .merge(moving: @moving))
    if @household_item.save
      flash.now[:success] = "Item created"
      redirect_to new_moving_household_item_url @moving
    else
      @moving = Moving.find(params[:moving_id])
      flash.now[:danger] = @household_item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @household_item.update(household_item_params)
      flash[:info] = "Item updated"
      redirect_to @moving
    else
      render :edit
    end
  end

  def destroy
    @household_item.destroy
    flash[:info] = "Item deleted"
    if request.referer == new_moving_household_item_url
      redirect_to new_moving_household_item_url
    else
      redirect_to @moving
    end
  end

  private

    def household_item_params
      params.require(:household_item).permit(:name, :volume, :quantity, :all_tags, :description, :moving_id)
    end

    # Make sure that we access movings through current_user.
    def set_current_user_moving
      @moving = current_user.movings.find(params[:moving_id])
    end

    # Make sure that we access household_items through current_user.
    def set_household_item
      @household_item = @moving.household_items.find(params[:id])
    end
end
