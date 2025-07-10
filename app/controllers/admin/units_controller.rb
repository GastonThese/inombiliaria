class Admin::UnitsController < ApplicationController
  def show
  end

  def new
    @unit = Unit.new
    load_info
  end

  def create
    @unit = Unit.new(unit_params)
    debugger

    if @unit.save
      redirect_to admin_unit_path(@unit), notice: "La unidad #{@unit.number} ha sido creada exitosamente."
    else
      load_info
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def unit_params
    params.require(:unit).permit(:number, :owner_id, :tenant_id, :building_id)
  end

  def load_info
    puts '-------------------owner----------------------'
      @owners = User.with_role(:owner)
    puts '-------------------tenant---------------------'
      @tenants = User.with_role(:tenant)
    puts '-------------------building-------------------'
      @building = Building.find(params[:building_id]) if params[:building_id].present?
    puts '-------------------end------------------------'
  end
end
