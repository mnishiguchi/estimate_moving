class HouseholdItemsController < ApplicationController
  before_action :authenticate_user!      # All actions
  before_action :set_current_user_moving # All actions
  before_action :set_household_item, only: [:show, :edit, :update, :destroy]

  # A list of all items is dieplayed in movings#show page
  # (instead of household_items#index).

  def show
  end

  # The add form is in movings#show.
  def create
    @household_item = @moving.household_items.new(household_item_params
                                                  .merge(moving: @moving))
    if @household_item.save
      flash[:success] = "Item created"
      redirect_to moving_url(@moving)
    else

      render 'movings/show'
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
    redirect_to @moving
  end

  private

    def household_item_params
      params.require(:household_item).permit(:name, :volume, :quantity, :all_tags, :description)
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
