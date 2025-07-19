class Admin::RealStatesController < ApplicationController
  before_action :authenticate_user!

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
  def validate_users_and_roles!(tenant_id: nil, owner_id: nil)
    tenant = User.find(tenant_id) if tenant_id.present?
    owner = User.find(owner_id) if owner_id.present?
    raise ArgumentError, I18n.t('errors.role_not_correct_tenant') unless tenant&.has_role?(:tenant) if tenant.present?
    raise ArgumentError, I18n.t('errors.role_not_correct_owner') unless owner&.has_role?(:owner) if owner.present?
  end
end
