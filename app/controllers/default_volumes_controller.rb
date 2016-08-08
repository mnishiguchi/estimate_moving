class DefaultVolumesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_default_volume, only: [:show, :edit, :update, :destroy]

  include CsvHelper

  # GET /default_volumes
  # GET /default_volumes.json
  def index
    respond_to do |format|
      @default_volumes = DefaultVolume.all
      format.html
      format.csv do
        csv = DefaultVolumesCsv.new(@default_volumes)
        send_data csv.data, csv.config
      end
    end
  end

  # GET /default_volumes/1
  # GET /default_volumes/1.json
  def show
  end

  # GET /default_volumes/new
  def new
    @default_volume = DefaultVolume.new
  end

  # GET /default_volumes/1/edit
  def edit
  end

  # POST /default_volumes
  # POST /default_volumes.json
  def create
    @default_volume = DefaultVolume.new(default_volume_params)

    respond_to do |format|
      if @default_volume.save
        format.html { redirect_to @default_volume, notice: 'Default volume was successfully created.' }
        format.json { render :show, status: :created, location: @default_volume }
      else
        format.html { render :new }
        format.json { render json: @default_volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /default_volumes/1
  # PATCH/PUT /default_volumes/1.json
  def update
    respond_to do |format|
      if @default_volume.update(default_volume_params)
        format.html { redirect_to @default_volume, notice: 'Default volume was successfully updated.' }
        format.json { render :show, status: :ok, location: @default_volume }
      else
        format.html { render :edit }
        format.json { render json: @default_volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /default_volumes/1
  # DELETE /default_volumes/1.json
  def destroy
    @default_volume.destroy
    respond_to do |format|
      format.html { redirect_to default_volumes_url, notice: 'Default volume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_default_volume
      @default_volume = DefaultVolume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def default_volume_params
      params.require(:default_volume).permit(:volume, :name)
    end
end
