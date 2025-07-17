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
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

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
