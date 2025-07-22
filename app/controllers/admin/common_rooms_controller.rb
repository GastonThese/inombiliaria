class Admin::CommonRoomsController < ApplicationController
  load_and_authorize_resource
  def show
    @common_room = CommonRoom.find(params[:id])
    @building = @common_room.building
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_buildings_path, alert: 'Sala comunal no encontrada.'
  end

  def new
    @building = Building.find(params[:building_id])
    @common_room = CommonRoom.new(building: @building)
  end

  def create
    @common_room = CommonRoom.new(common_room_params)
    @common_room.building = Building.find(params[:building_id])

    if @common_room.save
      redirect_to admin_building_path(params[:building_id]), notice: 'Se ha creado la sala comunal exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_buildings_path, alert: 'Edificio no encontrado.'
  end

  def edit
    @common_room = CommonRoom.find(params[:id])
    @building = @common_room.building
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_buildings_path, alert: 'Sala comunal no encontrada.'
  end

  def update
    @common_room = CommonRoom.find(params[:id])
    @common_room.building = Building.find(params[:building_id])

    if @common_room.update(common_room_params)
      redirect_to admin_building_path(params[:building_id]), notice: 'Se ha actualizado la sala comunal exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_buildings_path, alert: 'Edificio no encontrado.'
  end

  private

  def common_room_params
    params.require(:common_room).permit(:name)
  end
end
