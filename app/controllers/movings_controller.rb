class MovingsController < ApplicationController

  # NOTE: Always retrieve movings through `current_user`.
  # Never directly retrieve movings from `Moving` model.
  # Logged-in user can access only his/her own movings.

  before_action :authenticate_user!
  before_action :set_user_moving, only: [:show, :edit, :update, :destroy]

  def index
    @movings = current_user.movings.all
  end

  def show
    # Use moving_household_items_path instead.
    redirect_to moving_household_items_url @moving
  end

  def new
    @moving = current_user.movings.new
  end

  def create
    @moving = current_user.movings.new(moving_params)
    if @moving.save
      flash[:success] = "Moving created"
      redirect_to @moving
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @moving.update(moving_params)
      flash[:success] = "Moving updated"
      redirect_to @moving
    else
      render :edit
    end
  end

  def destroy
    @moving.destroy
    flash[:success] = "Moving deleted"
    redirect_to movings_url
  end

  private

    def moving_params
      params.require(:moving).permit(:name, :unit, :description)
    end

    # Make sure that we access movings through current_user.
    def set_user_moving
      @moving = current_user.movings.find(params[:id])
    end
end
