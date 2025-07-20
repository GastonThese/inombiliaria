# app/controllers/concerns/user_role_validation.rb
module UserRoleValidation
  extend ActiveSupport::Concern
  
  def validate_users_and_roles!(tenant_id: nil, owner_id: nil)
    tenant = User.find(tenant_id) if tenant_id.present?
    owner = User.find(owner_id) if owner_id.present?

    raise ArgumentError, I18n.t('errors.role_not_correct_tenant') unless tenant&.has_role?(:tenant) if tenant.present?
    raise ArgumentError, I18n.t('errors.role_not_correct_owner') unless owner&.has_role?(:owner) if owner.present?
  end
end
