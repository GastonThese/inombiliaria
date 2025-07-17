class Admin::UnitsController < ApplicationController
  include UserRoleValidation

  before_action :authenticate_user!

  def show
    @unit = Unit.find(params[:id])
  end

  def new
    @unit = Unit.new
    load_info
  end

  def create
    @unit = Unit.new(unit_params)

    validate_users_and_roles!(tenant_id: @unit.tenant_id, owner_id: @unit.owner_id)
    search_building!(building_id: @unit.building_id)

    if @unit.save
      redirect_to admin_unit_path(@unit), notice: "La unidad #{@unit.number} ha sido creada exitosamente."
    else
      load_info
      render :new, status: :unprocessable_entity
    end
  rescue ArgumentError, ActiveRecord::RecordNotFound => e
    @unit = Unit.new(building_id: unit_params[:building_id], number: unit_params[:number], tenant_id: unit_params[:tenant_id], owner_id: unit_params[:owner_id])
    @unit.errors.add(:base, e.message)
    load_info
    render :new, status: :unprocessable_entity
  end

  def edit
    @unit = Unit.find(params[:id])
    load_info
  end

  def update
    validate_users_and_roles!(tenant_id: unit_params[:tenant_id], owner_id: unit_params[:owner_id])
    search_building!(building_id: unit_params[:building_id])
    
    @unit = Unit.find(params[:id])

    if @unit.update(unit_params)
      redirect_to admin_unit_path(@unit), notice: "La unidad #{@unit.number} ha sido actualizada exitosamente."
    else
      load_info
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    @unit = Unit.new(building_id: unit_params[:building_id], number: unit_params[:number])
    @unit.errors.add(:base, e.message)
    load_info
    render :new, status: :unprocessable_entity
  end

  def destroy
    @unit = Unit.find(params[:id])

    if @unit.destroy
      redirect_to admin_units_path, notice: "La unidad #{@unit.number} ha sido eliminada exitosamente."
    else
      render :index, alert: "No se pudo eliminar la unidad #{@unit.number}."
    end
  end

  def unit_params
    params.require(:unit).permit(:number, :owner_id, :tenant_id, :building_id)
  end

  def load_info
    @owners = User.with_role(:owner)
    @tenants = User.with_role(:tenant)
    @building = Building.find(params[:building_id] || @unit.building_id) if params[:building_id].present? || @unit.building_id
  end

  def search_building!(tenant_id: nil, owner_id: nil, building_id: nil)
    Building.find(building_id) if building_id.present?
  end
end
