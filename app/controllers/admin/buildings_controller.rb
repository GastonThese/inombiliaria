class Admin::BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @buildings = building_search_service
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(building_params)

    if @building.save
      redirect_to admin_building_path(@building), notice: "Edificio #{ @building.name } creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @building = Building.find(params[:id])
  end

/*************  ✨ Windsurf Command ⭐  *************/
  # PATCH /admin/buildings/:id
  # Actualiza un edificio existente.
  #
  # Par ametros:
  # * id [Integer] - Identificador del edificio a actualizar.
  # * building [Hash] - Atributos del edificio.
/*******  5619d37e-6a2e-499d-be44-0bd9c7dfd963  *******/
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

  def building_search_service
    Admin::SearchBuildingsService.new(query: params[:query], page: params[:page]).call
  end

  def is_admin?
    unless current_user.has_role? :admin
      redirect_to root_path, alert: "Acceso denegado."
    end
  end
end
