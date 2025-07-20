class Admin::RealStatesController < ApplicationController
  include UserRoleValidation

  before_action :authenticate_user!
  before_action :is_admin?

  include UserRoleValidation
  def new
    @real_state = RealState.new
    load_info
  end

  def create
    @real_state = RealState.new(real_state_params)

    validate_users_and_roles!(owner_id: @real_state.owner_id, tenant_id: @real_state.tenant_id)

    if @real_state.save
      redirect_to admin_real_state_path(@real_state), notice: "La propiedad #{@real_state.number} ha sido creada exitosamente."
    else
      load_info
      render :new, status: :unprocessable_entity
    end
  rescue  ActiveRecord::RecordNotFound => e
    @real_state = RealState.new(real_state_params)
    @real_state.errors.add(:base, e.message)
    load_info
    render :new, status: :unprocessable_entity
  end

  def index
    @real_states = real_state_search_service
  end

  def show
    @real_state = RealState.find(params[:id])
  end

  def edit
    load_info

    @real_state = RealState.find(params[:id])
  end

  def update
    @real_state = RealState.find(params[:id])
    validate_users_and_roles!(owner_id: real_state_params[:owner_id], tenant_id: real_state_params[:tenant_id])
    if @real_state.update(real_state_params)
      redirect_to admin_real_state_path(@real_state), notice: "La propiedad #{@real_state.number} ha sido actualizada exitosamente."
    else
      load_info
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    @real_state = RealState.new(real_state_params)
    @real_state.errors.add(:base, e.message)
    load_info
    render :new, status: :unprocessable_entity
  end

  def destroy
    @real_state = RealState.find(params[:id])

    if @real_state.destroy
      redirect_to admin_real_states_path, notice: "La propiedad #{@real_state.number} ha sido eliminada exitosamente."
    else
      render :index, alert: "No se pudo eliminar la propiedad #{@real_state.number}."
    end
  end

  private

  def real_state_search_service
    Admin::SearchRealStatesService.new(query: params[:query], page: params[:page]).call
  end

  def load_info
    @owners = User.with_role(:owner)
    @tenants = User.with_role(:tenant)
  end

  def real_state_params
    params.require(:real_state).permit(:number, :owner_id, :tenant_id, :address)
  end

  def is_admin?
    unless current_user.has_role?(:admin)
      redirect_to root_path, alert: 'Acceso denegado.'
    end
  end
end
