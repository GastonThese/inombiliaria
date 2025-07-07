class Admin::BuildingsController < ApplicationController
  before_action :authenticate_user!
  def index
    pattern = "%#{params[:query]&.strip}%"

    @buildings = Building.order("number").page(params[:page])

    if params[:query].present?
      buildingsByNumber = @buildings.where("CAST(number AS TEXT) ILIKE :q OR name ILIKE :q", q: pattern)
      @buildings = buildingsByNumber.order("number").page(params[:page])
      @buildings
    end
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(building_params)

    if @building.save
      redirect_to admin_buildings_path, notice: "Edificio #{ @building.name } creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @building = Building.find(params[:id])
  end

  def update
    @building = Building.find(params[:id])
    if @building.update(building_params)
      redirect_to admin_buildings_path
    else
      render :edit
    end
  end

  def show
    @building = Building.find(params[:id])
  end

  def destroy
    @building = Building.find(params[:id])

    if @building.destroy
      redirect_to admin_buildings_path
    else
      render :index
    end
  end

  private

  def building_params
    params.require(:building).permit(:number, :name, :address)
  end
end
