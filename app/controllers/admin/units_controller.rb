class Admin::UnitsController < ApplicationController
  def show
    @unit = Unit.find(params[:id])
  end

  def new
    @unit = Unit.new
    load_info
  end

  def create
    @unit = create_unit_service.call
    if @unit.persisted?
      redirect_to admin_unit_path(@unit), notice: "La unidad #{@unit.number} ha sido creada exitosamente."
    else
      load_info
      render :new, status: :unprocessable_entity
    end
  rescue ArgumentError, ActiveRecord::RecordNotFound => e
    @unit = Unit.new(building_id: unit_params[:building_id], number: unit_params[:number])
    @unit.errors.add(:base, e.message)
    load_info
    render :new, status: :unprocessable_entity
  end

  def edit
  end

  def update
  end

  def unit_params
    params.require(:unit).permit(:number, :owner_id, :tenant_id, :building_id)
  end

  def load_info
    @owners = User.with_role(:owner)
    @tenants = User.with_role(:tenant)
    @building = Building.find(params[:building_id] || @unit.building_id) if params[:building_id].present? || @unit.building_id
  end

  def create_unit_service
    Admin::CreateUnitService.new(
      tenant_id: unit_params[:tenant_id],
      owner_id: unit_params[:owner_id],
      building_id: unit_params[:building_id],
      number: unit_params[:number]
    )
  end
end
